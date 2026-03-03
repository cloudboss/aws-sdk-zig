const std = @import("std");

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

    pub const json_field_names = .{
        .lambda_invoke = "LambdaInvoke",
        .s3_put_object_copy = "S3PutObjectCopy",
        .s3_put_object_acl = "S3PutObjectAcl",
        .s3_put_object_tagging = "S3PutObjectTagging",
        .s3_delete_object_tagging = "S3DeleteObjectTagging",
        .s3_initiate_restore_object = "S3InitiateRestoreObject",
        .s3_put_object_legal_hold = "S3PutObjectLegalHold",
        .s3_put_object_retention = "S3PutObjectRetention",
        .s3_replicate_object = "S3ReplicateObject",
        .s3_compute_object_checksum = "S3ComputeObjectChecksum",
        .s3_update_object_encryption = "S3UpdateObjectEncryption",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .lambda_invoke => "LambdaInvoke",
            .s3_put_object_copy => "S3PutObjectCopy",
            .s3_put_object_acl => "S3PutObjectAcl",
            .s3_put_object_tagging => "S3PutObjectTagging",
            .s3_delete_object_tagging => "S3DeleteObjectTagging",
            .s3_initiate_restore_object => "S3InitiateRestoreObject",
            .s3_put_object_legal_hold => "S3PutObjectLegalHold",
            .s3_put_object_retention => "S3PutObjectRetention",
            .s3_replicate_object => "S3ReplicateObject",
            .s3_compute_object_checksum => "S3ComputeObjectChecksum",
            .s3_update_object_encryption => "S3UpdateObjectEncryption",
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
