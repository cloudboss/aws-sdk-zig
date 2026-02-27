/// The details of the worker attribute capability.
pub const WorkerAttributeCapability = struct {
    /// The name of the worker attribute capability.
    name: []const u8,

    /// The values of the worker amount capability.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
