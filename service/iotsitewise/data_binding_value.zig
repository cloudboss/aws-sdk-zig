const AssetModelPropertyBindingValue = @import("asset_model_property_binding_value.zig").AssetModelPropertyBindingValue;
const AssetPropertyBindingValue = @import("asset_property_binding_value.zig").AssetPropertyBindingValue;

/// Represents a value used in a data binding. It can be an asset property or an
/// asset model
/// property.
pub const DataBindingValue = struct {
    asset_model_property: ?AssetModelPropertyBindingValue = null,

    /// The asset property value used in the data binding.
    asset_property: ?AssetPropertyBindingValue = null,

    pub const json_field_names = .{
        .asset_model_property = "assetModelProperty",
        .asset_property = "assetProperty",
    };
};
