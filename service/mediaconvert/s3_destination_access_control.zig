const S3ObjectCannedAcl = @import("s3_object_canned_acl.zig").S3ObjectCannedAcl;

/// Optional. Have MediaConvert automatically apply Amazon S3 access control for
/// the outputs in this output group. When you don't use this setting, S3
/// automatically applies the default access control list PRIVATE.
pub const S3DestinationAccessControl = struct {
    /// Choose an Amazon S3 canned ACL for MediaConvert to apply to this output.
    canned_acl: ?S3ObjectCannedAcl = null,

    pub const json_field_names = .{
        .canned_acl = "CannedAcl",
    };
};
