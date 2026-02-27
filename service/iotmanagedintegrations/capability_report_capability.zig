/// The capability used in capability report.
pub const CapabilityReportCapability = struct {
    /// The capability actions used in the capability report.
    actions: []const []const u8,

    /// The capability events used in the capability report.
    events: []const []const u8,

    /// The id of the schema version.
    id: []const u8,

    /// The name of the capability.
    name: []const u8,

    /// The capability properties used in the capability report.
    properties: []const []const u8,

    /// The version of the capability.
    version: []const u8,

    pub const json_field_names = .{
        .actions = "actions",
        .events = "events",
        .id = "id",
        .name = "name",
        .properties = "properties",
        .version = "version",
    };
};
