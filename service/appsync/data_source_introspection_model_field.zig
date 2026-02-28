const DataSourceIntrospectionModelFieldType = @import("data_source_introspection_model_field_type.zig").DataSourceIntrospectionModelFieldType;

/// Represents the fields that were retrieved from the introspected data.
pub const DataSourceIntrospectionModelField = struct {
    /// The length value of the introspected field.
    length: i64 = 0,

    /// The name of the field that was retrieved from the introspected data.
    name: ?[]const u8,

    /// The `DataSourceIntrospectionModelFieldType` object data.
    type: ?DataSourceIntrospectionModelFieldType,

    pub const json_field_names = .{
        .length = "length",
        .name = "name",
        .type = "type",
    };
};
