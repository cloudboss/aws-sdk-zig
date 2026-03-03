const ApiGatewayApiAsset = @import("api_gateway_api_asset.zig").ApiGatewayApiAsset;
const LakeFormationDataPermissionAsset = @import("lake_formation_data_permission_asset.zig").LakeFormationDataPermissionAsset;
const RedshiftDataShareAsset = @import("redshift_data_share_asset.zig").RedshiftDataShareAsset;
const S3DataAccessAsset = @import("s3_data_access_asset.zig").S3DataAccessAsset;
const S3SnapshotAsset = @import("s3_snapshot_asset.zig").S3SnapshotAsset;

/// Details about the asset.
pub const AssetDetails = struct {
    /// Information about the API Gateway API asset.
    api_gateway_api_asset: ?ApiGatewayApiAsset = null,

    /// The AWS Lake Formation data permission that is the asset.
    lake_formation_data_permission_asset: ?LakeFormationDataPermissionAsset = null,

    /// The Amazon Redshift datashare that is the asset.
    redshift_data_share_asset: ?RedshiftDataShareAsset = null,

    /// The Amazon S3 data access that is the asset.
    s3_data_access_asset: ?S3DataAccessAsset = null,

    /// The Amazon S3 object that is the asset.
    s3_snapshot_asset: ?S3SnapshotAsset = null,

    pub const json_field_names = .{
        .api_gateway_api_asset = "ApiGatewayApiAsset",
        .lake_formation_data_permission_asset = "LakeFormationDataPermissionAsset",
        .redshift_data_share_asset = "RedshiftDataShareAsset",
        .s3_data_access_asset = "S3DataAccessAsset",
        .s3_snapshot_asset = "S3SnapshotAsset",
    };
};
