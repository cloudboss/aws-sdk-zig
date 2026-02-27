const aws = @import("aws");

/// Represents information about an action configuration.
pub const ActionConfiguration = struct {
    /// The configuration data for the action.
    configuration: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .configuration = "configuration",
    };
};
