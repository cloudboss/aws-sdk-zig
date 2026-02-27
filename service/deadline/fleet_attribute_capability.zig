/// Defines the fleet's capability name, minimum, and maximum.
pub const FleetAttributeCapability = struct {
    /// The name of the fleet attribute capability for the worker.
    name: []const u8,

    /// The number of fleet attribute capabilities.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
