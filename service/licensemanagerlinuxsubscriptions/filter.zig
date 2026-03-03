const Operator = @import("operator.zig").Operator;

/// A filter object that is used to return more specific results from a describe
/// operation.
/// Filters can be used to match a set of resources by specific criteria.
pub const Filter = struct {
    /// The type of name to filter by.
    name: ?[]const u8 = null,

    /// An operator for filtering results.
    operator: ?Operator = null,

    /// One or more values for the name to filter by.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .name = "Name",
        .operator = "Operator",
        .values = "Values",
    };
};
