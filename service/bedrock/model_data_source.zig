const S3DataSource = @import("s3_data_source.zig").S3DataSource;

/// The data source of the model to import.
pub const ModelDataSource = union(enum) {
    /// The Amazon S3 data source of the model to import.
    s_3_data_source: ?S3DataSource,

    pub const json_field_names = .{
        .s_3_data_source = "s3DataSource",
    };
};
