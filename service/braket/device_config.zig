/// Configures the primary device used to create and run an Amazon Braket hybrid
/// job.
pub const DeviceConfig = struct {
    /// The primary device ARN used to create and run an Amazon Braket hybrid job.
    device: []const u8,

    pub const json_field_names = .{
        .device = "device",
    };
};
