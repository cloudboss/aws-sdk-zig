/// A field that details a condition of the specifications for a deployment.
pub const DeploymentConditionalField = struct {
    /// The comparator of the condition.
    ///
    /// Valid values: `Equal | NotEqual`
    comparator: ?[]const u8 = null,

    /// The name of the deployment condition.
    name: ?[]const u8 = null,

    /// The value of the condition.
    value: ?[]const u8 = null,

    pub const json_field_names = .{
        .comparator = "comparator",
        .name = "name",
        .value = "value",
    };
};
