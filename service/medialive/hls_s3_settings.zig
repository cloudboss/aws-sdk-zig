const S3CannedAcl = @import("s3_canned_acl.zig").S3CannedAcl;

/// Hls S3 Settings
pub const HlsS3Settings = struct {
    /// Specify the canned ACL to apply to each S3 request. Defaults to none.
    canned_acl: ?S3CannedAcl = null,

    pub const json_field_names = .{
        .canned_acl = "CannedAcl",
    };
};
