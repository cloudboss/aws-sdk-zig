/// Information about an AMI that is currently in the Recycle Bin.
pub const ImageRecycleBinInfo = struct {
    /// The description of the AMI.
    description: ?[]const u8 = null,

    /// The ID of the AMI.
    image_id: ?[]const u8 = null,

    /// The name of the AMI.
    name: ?[]const u8 = null,

    /// The date and time when the AMI entered the Recycle Bin.
    recycle_bin_enter_time: ?i64 = null,

    /// The date and time when the AMI is to be permanently deleted from the Recycle
    /// Bin.
    recycle_bin_exit_time: ?i64 = null,
};
