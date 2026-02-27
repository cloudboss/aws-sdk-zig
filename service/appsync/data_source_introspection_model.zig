const DataSourceIntrospectionModelField = @import("data_source_introspection_model_field.zig").DataSourceIntrospectionModelField;
const DataSourceIntrospectionModelIndex = @import("data_source_introspection_model_index.zig").DataSourceIntrospectionModelIndex;

/// Contains the introspected data that was retrieved from the data source.
pub const DataSourceIntrospectionModel = struct {
    /// The `DataSourceIntrospectionModelField` object data.
    fields: ?[]const DataSourceIntrospectionModelField,

    /// The array of `DataSourceIntrospectionModelIndex` objects.
    indexes: ?[]const DataSourceIntrospectionModelIndex,

    /// The name of the model. For example, this could be the name of a single table
    /// in a
    /// database.
    name: ?[]const u8,

    /// The primary key stored as a `DataSourceIntrospectionModelIndex`
    /// object.
    primary_key: ?DataSourceIntrospectionModelIndex,

    /// Contains the output of the SDL that was generated from the introspected
    /// types. This is
    /// controlled by the `includeModelsSDL` parameter of the
    /// `GetDataSourceIntrospection` operation.
    sdl: ?[]const u8,

    pub const json_field_names = .{
        .fields = "fields",
        .indexes = "indexes",
        .name = "name",
        .primary_key = "primaryKey",
        .sdl = "sdl",
    };
};
