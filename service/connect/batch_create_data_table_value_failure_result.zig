const PrimaryValue = @import("primary_value.zig").PrimaryValue;

/// A batch create data table value failure result.
pub const BatchCreateDataTableValueFailureResult = struct {
    /// The result's attribute name.
    attribute_name: []const u8,

    /// The result's message.
    message: []const u8,

    /// The result's primary values.
    primary_values: []const PrimaryValue,

    pub const json_field_names = .{
        .attribute_name = "AttributeName",
        .message = "Message",
        .primary_values = "PrimaryValues",
    };
};
