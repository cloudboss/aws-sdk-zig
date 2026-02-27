/// A value that indicates the AMI information.
pub const CustomDBEngineVersionAMI = struct {
    /// A value that indicates the ID of the AMI.
    image_id: ?[]const u8,

    /// A value that indicates the status of a custom engine version (CEV).
    status: ?[]const u8,
};
