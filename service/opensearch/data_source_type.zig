const S3GlueDataCatalog = @import("s3_glue_data_catalog.zig").S3GlueDataCatalog;

/// The type of data source.
pub const DataSourceType = union(enum) {
    /// An Amazon S3 data source.
    s3_glue_data_catalog: ?S3GlueDataCatalog,

    pub const json_field_names = .{
        .s3_glue_data_catalog = "S3GlueDataCatalog",
    };
};
