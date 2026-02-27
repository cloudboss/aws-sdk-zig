/// Contains a key/value pair that sets the named workflow parameter.
pub const WorkflowParameter = struct {
    /// The name of the workflow parameter to set.
    name: []const u8,

    /// Sets the value for the named workflow parameter.
    value: []const []const u8,

    pub const json_field_names = .{
        .name = "name",
        .value = "value",
    };
};
