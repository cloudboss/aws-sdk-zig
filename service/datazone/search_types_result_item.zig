const AssetTypeItem = @import("asset_type_item.zig").AssetTypeItem;
const FormTypeData = @import("form_type_data.zig").FormTypeData;
const LineageNodeTypeItem = @import("lineage_node_type_item.zig").LineageNodeTypeItem;

/// The details of the results of the `SearchTypes` action.
pub const SearchTypesResultItem = union(enum) {
    /// The asset type included in the results of the `SearchTypes` action.
    asset_type_item: ?AssetTypeItem,
    /// The form type included in the results of the `SearchTypes` action.
    form_type_item: ?FormTypeData,
    /// The details of a data lineage node type.
    lineage_node_type_item: ?LineageNodeTypeItem,

    pub const json_field_names = .{
        .asset_type_item = "assetTypeItem",
        .form_type_item = "formTypeItem",
        .lineage_node_type_item = "lineageNodeTypeItem",
    };
};
