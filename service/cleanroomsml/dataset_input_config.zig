const DataSource = @import("data_source.zig").DataSource;
const ColumnSchema = @import("column_schema.zig").ColumnSchema;

/// Defines the Glue data source and schema mapping information.
pub const DatasetInputConfig = struct {
    /// A DataSource object that specifies the Glue data source for the training
    /// data.
    data_source: DataSource,

    /// The schema information for the training data.
    schema: []const ColumnSchema,

    pub const json_field_names = .{
        .data_source = "dataSource",
        .schema = "schema",
    };
};
