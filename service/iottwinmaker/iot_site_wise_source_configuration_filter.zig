const FilterByAsset = @import("filter_by_asset.zig").FilterByAsset;
const FilterByAssetModel = @import("filter_by_asset_model.zig").FilterByAssetModel;

/// The AWS IoT SiteWise soucre configuration filter.[need held with desc here]
pub const IotSiteWiseSourceConfigurationFilter = union(enum) {
    /// Filter by asset.
    filter_by_asset: ?FilterByAsset,
    /// Filter by asset model.
    filter_by_asset_model: ?FilterByAssetModel,

    pub const json_field_names = .{
        .filter_by_asset = "filterByAsset",
        .filter_by_asset_model = "filterByAssetModel",
    };
};
