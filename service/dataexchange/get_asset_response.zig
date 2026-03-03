const AssetDetails = @import("asset_details.zig").AssetDetails;
const AssetType = @import("asset_type.zig").AssetType;

pub const GetAssetResponse = struct {
    /// The ARN for the asset.
    arn: ?[]const u8 = null,

    /// Details about the asset.
    asset_details: ?AssetDetails = null,

    /// The type of asset that is added to a data set.
    asset_type: ?AssetType = null,

    /// The date and time that the asset was created, in ISO 8601 format.
    created_at: ?i64 = null,

    /// The unique identifier for the data set associated with this asset.
    data_set_id: ?[]const u8 = null,

    /// The unique identifier for the asset.
    id: ?[]const u8 = null,

    /// The name of the asset. When importing from Amazon S3, the Amazon S3 object
    /// key is used
    /// as the asset name. When exporting to Amazon S3, the asset name is used as
    /// default target
    /// Amazon S3 object key. When importing from Amazon API Gateway API, the API
    /// name is used as
    /// the asset name. When importing from Amazon Redshift, the datashare name is
    /// used as the
    /// asset name. When importing from AWS Lake Formation, the static values of
    /// "Database(s)
    /// included in the LF-tag policy" or "Table(s) included in the LF-tag policy"
    /// are used as the
    /// asset name.
    name: ?[]const u8 = null,

    /// The unique identifier for the revision associated with this asset.
    revision_id: ?[]const u8 = null,

    /// The asset ID of the owned asset corresponding to the entitled asset being
    /// viewed. This
    /// parameter is returned when an asset owner is viewing the entitled copy of
    /// its owned
    /// asset.
    source_id: ?[]const u8 = null,

    /// The date and time that the asset was last updated, in ISO 8601 format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .asset_details = "AssetDetails",
        .asset_type = "AssetType",
        .created_at = "CreatedAt",
        .data_set_id = "DataSetId",
        .id = "Id",
        .name = "Name",
        .revision_id = "RevisionId",
        .source_id = "SourceId",
        .updated_at = "UpdatedAt",
    };
};
