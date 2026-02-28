const FieldType = @import("field_type.zig").FieldType;

/// Describes the name and data type at a field.
pub const Field = struct {
    /// The name of the field.
    name: ?[]const u8,

    /// The data type of the field.
    @"type": ?FieldType,

    pub const json_field_names = .{
        .name = "name",
        .@"type" = "type",
    };
};
