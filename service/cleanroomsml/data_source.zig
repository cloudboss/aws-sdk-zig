const GlueDataSource = @import("glue_data_source.zig").GlueDataSource;

/// Defines information about the Glue data source that contains the training
/// data.
pub const DataSource = struct {
    /// A GlueDataSource object that defines the catalog ID, database name, and
    /// table name for the training data.
    glue_data_source: GlueDataSource,

    pub const json_field_names = .{
        .glue_data_source = "glueDataSource",
    };
};
