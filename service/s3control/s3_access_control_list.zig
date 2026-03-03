const S3Grant = @import("s3_grant.zig").S3Grant;
const S3ObjectOwner = @import("s3_object_owner.zig").S3ObjectOwner;

pub const S3AccessControlList = struct {
    grants: ?[]const S3Grant = null,

    owner: S3ObjectOwner,
};
