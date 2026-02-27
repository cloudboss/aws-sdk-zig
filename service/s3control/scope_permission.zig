pub const ScopePermission = enum {
    get_object,
    get_object_attributes,
    list_multipart_upload_parts,
    list_bucket,
    list_bucket_multipart_uploads,
    put_object,
    delete_object,
    abort_multipart_upload,
};
