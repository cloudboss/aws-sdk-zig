pub const AssetModelType = enum {
    asset_model,
    component_model,
    interface,

    pub const json_field_names = .{
        .asset_model = "ASSET_MODEL",
        .component_model = "COMPONENT_MODEL",
        .interface = "INTERFACE",
    };
};
