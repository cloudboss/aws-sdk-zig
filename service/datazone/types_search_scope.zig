pub const TypesSearchScope = enum {
    asset_type,
    form_type,
    lineage_node_type,

    pub const json_field_names = .{
        .asset_type = "ASSET_TYPE",
        .form_type = "FORM_TYPE",
        .lineage_node_type = "LINEAGE_NODE_TYPE",
    };
};
