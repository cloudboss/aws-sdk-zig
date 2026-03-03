const std = @import("std");

pub const InventoryOptionalField = enum {
    size,
    last_modified_date,
    storage_class,
    e_tag,
    is_multipart_uploaded,
    replication_status,
    encryption_status,
    object_lock_retain_until_date,
    object_lock_mode,
    object_lock_legal_hold_status,
    intelligent_tiering_access_tier,
    bucket_key_status,
    checksum_algorithm,
    object_access_control_list,
    object_owner,
    lifecycle_expiration_date,

    pub const json_field_names = .{
        .size = "Size",
        .last_modified_date = "LastModifiedDate",
        .storage_class = "StorageClass",
        .e_tag = "ETag",
        .is_multipart_uploaded = "IsMultipartUploaded",
        .replication_status = "ReplicationStatus",
        .encryption_status = "EncryptionStatus",
        .object_lock_retain_until_date = "ObjectLockRetainUntilDate",
        .object_lock_mode = "ObjectLockMode",
        .object_lock_legal_hold_status = "ObjectLockLegalHoldStatus",
        .intelligent_tiering_access_tier = "IntelligentTieringAccessTier",
        .bucket_key_status = "BucketKeyStatus",
        .checksum_algorithm = "ChecksumAlgorithm",
        .object_access_control_list = "ObjectAccessControlList",
        .object_owner = "ObjectOwner",
        .lifecycle_expiration_date = "LifecycleExpirationDate",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .size => "Size",
            .last_modified_date => "LastModifiedDate",
            .storage_class => "StorageClass",
            .e_tag => "ETag",
            .is_multipart_uploaded => "IsMultipartUploaded",
            .replication_status => "ReplicationStatus",
            .encryption_status => "EncryptionStatus",
            .object_lock_retain_until_date => "ObjectLockRetainUntilDate",
            .object_lock_mode => "ObjectLockMode",
            .object_lock_legal_hold_status => "ObjectLockLegalHoldStatus",
            .intelligent_tiering_access_tier => "IntelligentTieringAccessTier",
            .bucket_key_status => "BucketKeyStatus",
            .checksum_algorithm => "ChecksumAlgorithm",
            .object_access_control_list => "ObjectAccessControlList",
            .object_owner => "ObjectOwner",
            .lifecycle_expiration_date => "LifecycleExpirationDate",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
