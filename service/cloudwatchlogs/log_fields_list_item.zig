const LogFieldType = @import("log_field_type.zig").LogFieldType;

/// Represents a log field with its name and data type information for a
/// specific data
/// source.
pub const LogFieldsListItem = struct {
    /// The name of the log field.
    log_field_name: ?[]const u8,

    /// The data type information for the log field.
    log_field_type: ?*LogFieldType = null,

    pub const json_field_names = .{
        .log_field_name = "logFieldName",
        .log_field_type = "logFieldType",
    };
};
