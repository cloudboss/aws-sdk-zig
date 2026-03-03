const S3AccessControlList = @import("s3_access_control_list.zig").S3AccessControlList;
const S3CannedAccessControlList = @import("s3_canned_access_control_list.zig").S3CannedAccessControlList;

pub const S3AccessControlPolicy = struct {
    access_control_list: ?S3AccessControlList = null,

    canned_access_control_list: ?S3CannedAccessControlList = null,
};
