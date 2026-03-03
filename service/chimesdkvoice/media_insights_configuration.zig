/// The configuration for a call analytics task.
pub const MediaInsightsConfiguration = struct {
    /// The configuration's ARN.
    configuration_arn: ?[]const u8 = null,

    /// Denotes the configuration as enabled or disabled.
    disabled: ?bool = null,

    pub const json_field_names = .{
        .configuration_arn = "ConfigurationArn",
        .disabled = "Disabled",
    };
};
