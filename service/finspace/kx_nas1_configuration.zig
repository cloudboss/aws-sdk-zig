const KxNAS1Type = @import("kx_nas1_type.zig").KxNAS1Type;

/// The structure containing the size and type of the network attached storage
/// (NAS_1) file system volume.
pub const KxNAS1Configuration = struct {
    /// The size of the network attached storage. For storage type
    /// `SSD_1000` and `SSD_250` you can select the
    /// minimum size as 1200 GB or increments of 2400 GB. For storage type
    /// `HDD_12` you can select the minimum size as 6000 GB or increments
    /// of 6000 GB.
    size: ?i32 = null,

    /// The type of the network attached storage.
    @"type": ?KxNAS1Type = null,

    pub const json_field_names = .{
        .size = "size",
        .@"type" = "type",
    };
};
