/// The active context used in the test execution.
pub const ActiveContext = struct {
    /// The name of active context.
    name: []const u8,

    pub const json_field_names = .{
        .name = "name",
    };
};
