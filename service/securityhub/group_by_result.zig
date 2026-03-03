const GroupByValue = @import("group_by_value.zig").GroupByValue;

/// Represents finding statistics grouped by `GroupedByField`.
pub const GroupByResult = struct {
    /// The attribute by which filtered security findings should be grouped.
    group_by_field: ?[]const u8 = null,

    /// An array of grouped values and their respective counts for each
    /// `GroupByField`.
    group_by_values: ?[]const GroupByValue = null,

    pub const json_field_names = .{
        .group_by_field = "GroupByField",
        .group_by_values = "GroupByValues",
    };
};
