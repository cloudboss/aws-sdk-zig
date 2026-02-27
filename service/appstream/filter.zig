/// A filter for narrowing down the results when listing export image tasks.
/// Filters allow you to specify criteria such as task state or creation date.
pub const Filter = struct {
    /// The name of the filter. Valid filter names depend on the operation being
    /// performed.
    name: []const u8,

    /// The values for the filter. Multiple values can be specified for a single
    /// filter name.
    values: []const []const u8,

    pub const json_field_names = .{
        .name = "Name",
        .values = "Values",
    };
};
