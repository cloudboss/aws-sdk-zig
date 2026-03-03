/// Indicates whether to enable CloudWatch Container Insights for the ECS
/// cluster.
pub const AwsEcsClusterClusterSettingsDetails = struct {
    /// The name of the setting. The valid value is `containerInsights`.
    name: ?[]const u8 = null,

    /// The value of the setting. Valid values are `disabled` or `enabled`.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .value = "Value",
    };
};
