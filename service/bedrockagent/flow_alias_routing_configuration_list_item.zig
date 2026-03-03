/// Contains information about a version that the alias maps to.
pub const FlowAliasRoutingConfigurationListItem = struct {
    /// The version that the alias maps to.
    flow_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .flow_version = "flowVersion",
    };
};
