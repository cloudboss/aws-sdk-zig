pub const MarketplaceResourceType = enum {
    component_data,
    component_artifact,

    pub const json_field_names = .{
        .component_data = "COMPONENT_DATA",
        .component_artifact = "COMPONENT_ARTIFACT",
    };
};
