const CreateS3DataAccessFromS3BucketRequestDetails = @import("create_s3_data_access_from_s3_bucket_request_details.zig").CreateS3DataAccessFromS3BucketRequestDetails;
const ExportAssetsToS3RequestDetails = @import("export_assets_to_s3_request_details.zig").ExportAssetsToS3RequestDetails;
const ExportAssetToSignedUrlRequestDetails = @import("export_asset_to_signed_url_request_details.zig").ExportAssetToSignedUrlRequestDetails;
const ExportRevisionsToS3RequestDetails = @import("export_revisions_to_s3_request_details.zig").ExportRevisionsToS3RequestDetails;
const ImportAssetFromApiGatewayApiRequestDetails = @import("import_asset_from_api_gateway_api_request_details.zig").ImportAssetFromApiGatewayApiRequestDetails;
const ImportAssetFromSignedUrlRequestDetails = @import("import_asset_from_signed_url_request_details.zig").ImportAssetFromSignedUrlRequestDetails;
const ImportAssetsFromLakeFormationTagPolicyRequestDetails = @import("import_assets_from_lake_formation_tag_policy_request_details.zig").ImportAssetsFromLakeFormationTagPolicyRequestDetails;
const ImportAssetsFromRedshiftDataSharesRequestDetails = @import("import_assets_from_redshift_data_shares_request_details.zig").ImportAssetsFromRedshiftDataSharesRequestDetails;
const ImportAssetsFromS3RequestDetails = @import("import_assets_from_s3_request_details.zig").ImportAssetsFromS3RequestDetails;

/// The details for the request.
pub const RequestDetails = struct {
    /// Details of the request to create S3 data access from the Amazon S3 bucket.
    create_s3_data_access_from_s3_bucket: ?CreateS3DataAccessFromS3BucketRequestDetails = null,

    /// Details about the export to Amazon S3 request.
    export_assets_to_s3: ?ExportAssetsToS3RequestDetails = null,

    /// Details about the export to signed URL request.
    export_asset_to_signed_url: ?ExportAssetToSignedUrlRequestDetails = null,

    /// Details about the export to Amazon S3 request.
    export_revisions_to_s3: ?ExportRevisionsToS3RequestDetails = null,

    /// Details about the import from signed URL request.
    import_asset_from_api_gateway_api: ?ImportAssetFromApiGatewayApiRequestDetails = null,

    /// Details about the import from Amazon S3 request.
    import_asset_from_signed_url: ?ImportAssetFromSignedUrlRequestDetails = null,

    /// Request details for the ImportAssetsFromLakeFormationTagPolicy job.
    import_assets_from_lake_formation_tag_policy: ?ImportAssetsFromLakeFormationTagPolicyRequestDetails = null,

    /// Details from an import from Amazon Redshift datashare request.
    import_assets_from_redshift_data_shares: ?ImportAssetsFromRedshiftDataSharesRequestDetails = null,

    /// Details about the import asset from API Gateway API request.
    import_assets_from_s3: ?ImportAssetsFromS3RequestDetails = null,

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
