/// An activity that filters a message based on its attributes.
pub const FilterActivity = struct {
    /// An expression that looks like a SQL WHERE clause that must return a Boolean
    /// value.
    /// Messages that satisfy the condition are passed to the next activity.
    filter: []const u8,

    /// The name of the filter activity.
    name: []const u8,

    /// The next activity in the pipeline.
    next: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter = "filter",
        .name = "name",
        .next = "next",
    };
};
