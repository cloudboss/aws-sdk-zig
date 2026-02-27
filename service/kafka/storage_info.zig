const EBSStorageInfo = @import("ebs_storage_info.zig").EBSStorageInfo;

/// Contains information about storage volumes attached to MSK broker nodes.
pub const StorageInfo = struct {
    /// EBS volume information.
    ebs_storage_info: ?EBSStorageInfo,

    pub const json_field_names = .{
        .ebs_storage_info = "EbsStorageInfo",
    };
};
