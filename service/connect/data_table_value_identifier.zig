const PrimaryValue = @import("primary_value.zig").PrimaryValue;

/// A data table value identifier.
pub const DataTableValueIdentifier = struct {
    /// The identifier's attribute name.
    attribute_name: []const u8,

    /// The identifier's primary values.
    primary_values: ?[]const PrimaryValue = null,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .primary_values = "PrimaryValues",
    };
};
