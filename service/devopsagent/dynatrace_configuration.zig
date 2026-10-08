/// Configuration for Dynatrace monitoring integration.
pub const DynatraceConfiguration = struct {
    /// Dynatrace environment id
    env_id: []const u8,

    /// List of Dynatrace resources to monitor
    resources: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .env_id = "envId",
        .resources = "resources",
    };
};
