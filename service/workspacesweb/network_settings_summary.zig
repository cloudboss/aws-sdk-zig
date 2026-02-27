/// The summary of network settings.
pub const NetworkSettingsSummary = struct {
    /// The ARN of the network settings.
    network_settings_arn: []const u8,

    /// The VPC ID of the network settings.
    vpc_id: ?[]const u8,

    pub const json_field_names = .{
        .network_settings_arn = "networkSettingsArn",
        .vpc_id = "vpcId",
    };
};
