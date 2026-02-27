const FieldDataType = @import("field_data_type.zig").FieldDataType;

/// Defines a field in an entity schema for REST connector data sources,
/// specifying the field name and data type.
pub const FieldDefinition = struct {
    /// The data type of the field.
    field_data_type: FieldDataType,

    /// The name of the field in the entity schema.
    name: []const u8,

    pub const json_field_names = .{
        .field_data_type = "FieldDataType",
        .name = "Name",
    };
};
