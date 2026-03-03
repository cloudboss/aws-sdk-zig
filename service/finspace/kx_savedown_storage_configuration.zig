const KxSavedownStorageType = @import("kx_savedown_storage_type.zig").KxSavedownStorageType;

/// The size and type of temporary storage that is used to hold data during the
/// savedown process. All the data written to this storage space is lost when
/// the cluster node is restarted.
pub const KxSavedownStorageConfiguration = struct {
    /// The size of temporary storage in gibibytes.
    size: ?i32 = null,

    /// The type of writeable storage space for temporarily storing your savedown
    /// data. The valid values are:
    ///
    /// * SDS01 – This type represents 3000 IOPS and io2 ebs volume type.
    @"type": ?KxSavedownStorageType = null,

    /// The name of the kdb volume that you want to use as writeable save-down
    /// storage for clusters.
    volume_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .size = "size",
        .@"type" = "type",
        .volume_name = "volumeName",
    };
};
