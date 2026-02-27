const AssetModelPropertyBindingValue = @import("asset_model_property_binding_value.zig").AssetModelPropertyBindingValue;
const AssetPropertyBindingValue = @import("asset_property_binding_value.zig").AssetPropertyBindingValue;

/// Contains computation model data binding value information, which can be one
/// of
/// `assetModelProperty`, `list`.
pub const ComputationModelDataBindingValue = struct {
    /// Specifies an asset model property data binding value.
    asset_model_property: ?AssetModelPropertyBindingValue,

    /// The asset property value used for computation model data binding.
    asset_property: ?AssetPropertyBindingValue,

    /// Specifies a list of data binding value.
    list: ?[]const ComputationModelDataBindingValue,

    pub const json_field_names = .{
        .asset_model_property = "assetModelProperty",
        .asset_property = "assetProperty",
        .list = "list",
    };
};
