pub const OperationName = enum {
    lambda_invoke,
    s3_put_object_copy,
    s3_put_object_acl,
    s3_put_object_tagging,
    s3_delete_object_tagging,
    s3_initiate_restore_object,
    s3_put_object_legal_hold,
    s3_put_object_retention,
    s3_replicate_object,
    s3_compute_object_checksum,
    s3_update_object_encryption,
};
