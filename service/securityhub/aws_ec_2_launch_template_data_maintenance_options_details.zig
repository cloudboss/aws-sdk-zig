/// The maintenance options of an Amazon EC2 instance.
pub const AwsEc2LaunchTemplateDataMaintenanceOptionsDetails = struct {
    /// Disables the automatic recovery behavior of your instance or sets it to
    /// default.
    auto_recovery: ?[]const u8 = null,

    pub const json_field_names = .{
        .auto_recovery = "AutoRecovery",
    };
};
