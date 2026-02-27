pub const Type = enum {
    import_assets_from_s3,
    import_asset_from_signed_url,
    export_assets_to_s3,
    export_asset_to_signed_url,
    export_revisions_to_s3,
    import_assets_from_redshift_data_shares,
    import_asset_from_api_gateway_api,
    create_s3_data_access_from_s3_bucket,
    import_assets_from_lake_formation_tag_policy,

    pub const json_field_names = .{
        .import_assets_from_s3 = "IMPORT_ASSETS_FROM_S3",
        .import_asset_from_signed_url = "IMPORT_ASSET_FROM_SIGNED_URL",
        .export_assets_to_s3 = "EXPORT_ASSETS_TO_S3",
        .export_asset_to_signed_url = "EXPORT_ASSET_TO_SIGNED_URL",
        .export_revisions_to_s3 = "EXPORT_REVISIONS_TO_S3",
        .import_assets_from_redshift_data_shares = "IMPORT_ASSETS_FROM_REDSHIFT_DATA_SHARES",
        .import_asset_from_api_gateway_api = "IMPORT_ASSET_FROM_API_GATEWAY_API",
        .create_s3_data_access_from_s3_bucket = "CREATE_S3_DATA_ACCESS_FROM_S3_BUCKET",
        .import_assets_from_lake_formation_tag_policy = "IMPORT_ASSETS_FROM_LAKE_FORMATION_TAG_POLICY",
    };
};
