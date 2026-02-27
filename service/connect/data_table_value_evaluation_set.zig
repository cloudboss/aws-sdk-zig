const PrimaryValue = @import("primary_value.zig").PrimaryValue;

/// A data table value evaluation set.
pub const DataTableValueEvaluationSet = struct {
    /// The set's attribute names.
    attribute_names: []const []const u8,

    /// The set's primary values.
    primary_values: ?[]const PrimaryValue,

    pub const json_field_names = .{
        .attribute_names = "AttributeNames",
        .primary_values = "PrimaryValues",
    };
};
