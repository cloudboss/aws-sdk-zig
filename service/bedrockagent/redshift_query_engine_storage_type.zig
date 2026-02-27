pub const RedshiftQueryEngineStorageType = enum {
    redshift,
    aws_data_catalog,

    pub const json_field_names = .{
        .redshift = "REDSHIFT",
        .aws_data_catalog = "AWS_DATA_CATALOG",
    };
};
