const AssetBindingValueFilter = @import("asset_binding_value_filter.zig").AssetBindingValueFilter;
const AssetModelBindingValueFilter = @import("asset_model_binding_value_filter.zig").AssetModelBindingValueFilter;
const AssetModelPropertyBindingValueFilter = @import("asset_model_property_binding_value_filter.zig").AssetModelPropertyBindingValueFilter;
const AssetPropertyBindingValueFilter = @import("asset_property_binding_value_filter.zig").AssetPropertyBindingValueFilter;

/// A filter used to match specific data binding values based on criteria. This
/// filter allows
/// searching for data bindings by asset, asset model, asset property, or asset
/// model
/// property.
pub const DataBindingValueFilter = struct {
    /// Filter criteria for matching data bindings based on a specific asset. Used
    /// to list all
    /// data bindings referencing a particular asset or its properties.
    asset: ?AssetBindingValueFilter = null,

    /// Filter criteria for matching data bindings based on a specific asset model.
    /// Used to list
    /// all data bindings referencing a particular asset model or its properties.
    asset_model: ?AssetModelBindingValueFilter = null,

    /// Filter criteria for matching data bindings based on a specific asset model
    /// property. Used
    /// to list all data bindings referencing a particular property of an asset
    /// model.
    asset_model_property: ?AssetModelPropertyBindingValueFilter = null,

    /// Filter criteria for matching data bindings based on a specific asset
    /// property. Used to
    /// list all data bindings referencing a particular property of an asset.
    asset_property: ?AssetPropertyBindingValueFilter = null,

    pub const json_field_names = .{
        .asset = "asset",
        .asset_model = "assetModel",
        .asset_model_property = "assetModelProperty",
        .asset_property = "assetProperty",
    };
};
