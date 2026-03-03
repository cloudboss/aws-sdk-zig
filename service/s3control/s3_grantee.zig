const S3GranteeTypeIdentifier = @import("s3_grantee_type_identifier.zig").S3GranteeTypeIdentifier;

pub const S3Grantee = struct {
    display_name: ?[]const u8 = null,

    identifier: ?[]const u8 = null,

    type_identifier: ?S3GranteeTypeIdentifier = null,
};
