-- ====================================================================
-- Konfigurasi Supabase Storage untuk Upload Gambar (Bucket 'uploads')
-- Jalankan query ini di: Supabase Dashboard -> SQL Editor -> New query -> Run
-- ====================================================================

-- 1. Buat bucket 'uploads' dan jadikan Public
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
    'uploads',
    'uploads',
    true,
    5242880, -- Maks 5 MB
    ARRAY['image/jpeg', 'image/png', 'image/webp', 'image/gif']
)
ON CONFLICT (id) DO UPDATE 
SET public = true,
    file_size_limit = 5242880,
    allowed_mime_types = ARRAY['image/jpeg', 'image/png', 'image/webp', 'image/gif'];

-- 2. Bersihkan policy lama jika sudah pernah dibuat
DROP POLICY IF EXISTS "Allow public select on uploads" ON storage.objects;
DROP POLICY IF EXISTS "Allow public insert on uploads" ON storage.objects;
DROP POLICY IF EXISTS "Allow public update on uploads" ON storage.objects;
DROP POLICY IF EXISTS "Allow public delete on uploads" ON storage.objects;
DROP POLICY IF EXISTS "Allow public uploads" ON storage.objects;
DROP POLICY IF EXISTS "Allow public select" ON storage.objects;
DROP POLICY IF EXISTS "Allow public update" ON storage.objects;
DROP POLICY IF EXISTS "Allow public delete" ON storage.objects;

-- 3. Pasang Policy baru agar backend web bisa upload, update, dan hapus gambar
CREATE POLICY "Allow public select on uploads"
ON storage.objects FOR SELECT
TO public
USING (bucket_id = 'uploads');

CREATE POLICY "Allow public insert on uploads"
ON storage.objects FOR INSERT
TO public
WITH CHECK (bucket_id = 'uploads');

CREATE POLICY "Allow public update on uploads"
ON storage.objects FOR UPDATE
TO public
WITH CHECK (bucket_id = 'uploads');

CREATE POLICY "Allow public delete on uploads"
ON storage.objects FOR DELETE
TO public
USING (bucket_id = 'uploads');
