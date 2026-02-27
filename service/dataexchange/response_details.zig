const CreateS3DataAccessFromS3BucketResponseDetails = @import("create_s3_data_access_from_s3_bucket_response_details.zig").CreateS3DataAccessFromS3BucketResponseDetails;
const ExportAssetsToS3ResponseDetails = @import("export_assets_to_s3_response_details.zig").ExportAssetsToS3ResponseDetails;
const ExportAssetToSignedUrlResponseDetails = @import("export_asset_to_signed_url_response_details.zig").ExportAssetToSignedUrlResponseDetails;
const ExportRevisionsToS3ResponseDetails = @import("export_revisions_to_s3_response_details.zig").ExportRevisionsToS3ResponseDetails;
const ImportAssetFromApiGatewayApiResponseDetails = @import("import_asset_from_api_gateway_api_response_details.zig").ImportAssetFromApiGatewayApiResponseDetails;
const ImportAssetFromSignedUrlResponseDetails = @import("import_asset_from_signed_url_response_details.zig").ImportAssetFromSignedUrlResponseDetails;
const ImportAssetsFromLakeFormationTagPolicyResponseDetails = @import("import_assets_from_lake_formation_tag_policy_response_details.zig").ImportAssetsFromLakeFormationTagPolicyResponseDetails;
const ImportAssetsFromRedshiftDataSharesResponseDetails = @import("import_assets_from_redshift_data_shares_response_details.zig").ImportAssetsFromRedshiftDataSharesResponseDetails;
const ImportAssetsFromS3ResponseDetails = @import("import_assets_from_s3_response_details.zig").ImportAssetsFromS3ResponseDetails;

/// Details for the response.
pub const ResponseDetails = struct {
    /// Response details from the CreateS3DataAccessFromS3Bucket job.
    create_s3_data_access_from_s3_bucket: ?CreateS3DataAccessFromS3BucketResponseDetails,

    /// Details for the export to Amazon S3 response.
    export_assets_to_s3: ?ExportAssetsToS3ResponseDetails,

    /// Details for the export to signed URL response.
    export_asset_to_signed_url: ?ExportAssetToSignedUrlResponseDetails,

    /// Details for the export revisions to Amazon S3 response.
    export_revisions_to_s3: ?ExportRevisionsToS3ResponseDetails,

    /// The response details.
    import_asset_from_api_gateway_api: ?ImportAssetFromApiGatewayApiResponseDetails,

    /// Details for the import from signed URL response.
    import_asset_from_signed_url: ?ImportAssetFromSignedUrlResponseDetails,

    /// Response details from the ImportAssetsFromLakeFormationTagPolicy job.
    import_assets_from_lake_formation_tag_policy: ?ImportAssetsFromLakeFormationTagPolicyResponseDetails,

    /// Details from an import from Amazon Redshift datashare response.
    import_assets_from_redshift_data_shares: ?ImportAssetsFromRedshiftDataSharesResponseDetails,

    /// Details for the import from Amazon S3 response.
    import_assets_from_s3: ?ImportAssetsFromS3ResponseDetails,

    pub const json_field_names = .{
        .create_s3_data_access_from_s3_bucket = "CreateS3DataAccessFromS3Bucket",
        .export_assets_to_s3 = "ExportAssetsToS3",
        .export_asset_to_signed_url = "ExportAssetToSignedUrl",
        .export_revisions_to_s3 = "ExportRevisionsToS3",
        .import_asset_from_api_gateway_api = "ImportAssetFromApiGatewayApi",
        .import_asset_from_signed_url = "ImportAssetFromSignedUrl",
        .import_assets_from_lake_formation_tag_policy = "ImportAssetsFromLakeFormationTagPolicy",
        .import_assets_from_redshift_data_shares = "ImportAssetsFromRedshiftDataShares",
        .import_assets_from_s3 = "ImportAssetsFromS3",
    };
};
