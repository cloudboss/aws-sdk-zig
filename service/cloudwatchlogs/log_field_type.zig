const LogFieldsListItem = @import("log_fields_list_item.zig").LogFieldsListItem;

/// Defines the data type structure for a log field, including the type, element
/// information,
/// and nested fields for complex types.
pub const LogFieldType = struct {
    /// For array or collection types, specifies the element type information.
    element: ?*LogFieldType = null,

    /// For complex types, contains the nested field definitions.
    fields: ?[]const LogFieldsListItem = null,

    /// The data type of the log field.
    @"type": ?[]const u8 = null,

    pub const json_field_names = .{
        .element = "element",
        .fields = "fields",
        .@"type" = "type",
    };
};
