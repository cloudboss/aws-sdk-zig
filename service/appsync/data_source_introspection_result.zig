const DataSourceIntrospectionModel = @import("data_source_introspection_model.zig").DataSourceIntrospectionModel;

/// Represents the output of a `DataSourceIntrospectionResult`. This is the
/// populated result of a `GetDataSourceIntrospection` operation.
pub const DataSourceIntrospectionResult = struct {
    /// The array of `DataSourceIntrospectionModel` objects.
    models: ?[]const DataSourceIntrospectionModel,

    /// Determines the number of types to be returned in a single response before
    /// paginating.
    /// This value is typically taken from `nextToken` value from the previous
    /// response.
    next_token: ?[]const u8,

    pub const json_field_names = .{
        .models = "models",
        .next_token = "nextToken",
    };
};
