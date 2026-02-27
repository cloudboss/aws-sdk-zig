pub const JobErrorLimitName = enum {
    assets_per_revision,
    asset_size_in_gb,
    amazon_redshift_datashare_assets_per_revision,
    aws_lake_formation_data_permission_assets_per_revision,
    amazon_s3_data_access_assets_per_revision,

    pub const json_field_names = .{
        .assets_per_revision = "Assets_per_revision",
        .asset_size_in_gb = "Asset_size_in_GB",
        .amazon_redshift_datashare_assets_per_revision = "Amazon_Redshift_datashare_assets_per_revision",
        .aws_lake_formation_data_permission_assets_per_revision = "AWS_Lake_Formation_data_permission_assets_per_revision",
        .amazon_s3_data_access_assets_per_revision = "Amazon_S3_data_access_assets_per_revision",
    };
};
