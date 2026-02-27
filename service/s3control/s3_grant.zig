const S3Grantee = @import("s3_grantee.zig").S3Grantee;
const S3Permission = @import("s3_permission.zig").S3Permission;

pub const S3Grant = struct {
    grantee: ?S3Grantee,

    permission: ?S3Permission,
};
