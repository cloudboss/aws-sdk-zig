pub const AssetType = enum {
    s3_snapshot,
    redshift_data_share,
    api_gateway_api,
    s3_data_access,
    lake_formation_data_permission,

    pub const json_field_names = .{
        .s3_snapshot = "S3_SNAPSHOT",
        .redshift_data_share = "REDSHIFT_DATA_SHARE",
        .api_gateway_api = "API_GATEWAY_API",
        .s3_data_access = "S3_DATA_ACCESS",
        .lake_formation_data_permission = "LAKE_FORMATION_DATA_PERMISSION",
    };
};
