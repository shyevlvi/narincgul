-- Narıncgül: Profil şəkilləri üçün Supabase Storage quraşdırması
-- Bu skripti Supabase Dashboard -> SQL Editor bölməsində işə salın.

-- 1. "avatars" adlı public storage bucket yaradın (əgər yoxdursa)
insert into storage.buckets (id, name, public)
values ('avatars', 'avatars', true)
on conflict (id) do update set public = true;

-- 2. Hər kəsə avatar şəkillərini oxumağa icazə ver (Public View)
create policy "Avatarlar hər kəsə açıqdır"
on storage.objects for select
using ( bucket_id = 'avatars' );

-- 3. Yalnız daxil olmuş istifadəçi öz qovluğuna avatar yükləyə bilər (Upload)
create policy "İstifadəçi öz avatarını yükləyə bilər"
on storage.objects for insert
to authenticated
with check (
    bucket_id = 'avatars'
    and (storage.foldername(name))[1] = auth.uid()::text
);

-- 4. Yalnız daxil olmuş istifadəçi öz avatarını yeniləyə bilər (Update)
create policy "İstifadəçi öz avatarını yeniləyə bilər"
on storage.objects for update
to authenticated
using (
    bucket_id = 'avatars'
    and (storage.foldername(name))[1] = auth.uid()::text
);

-- 5. Yalnız daxil olmuş istifadəçi öz avatarını silə bilər (Delete)
create policy "İstifadəçi öz avatarını silə bilər"
on storage.objects for delete
to authenticated
using (
    bucket_id = 'avatars'
    and (storage.foldername(name))[1] = auth.uid()::text
);
