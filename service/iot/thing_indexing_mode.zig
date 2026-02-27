pub const ThingIndexingMode = enum {
    off,
    registry,
    registry_and_shadow,

    pub const json_field_names = .{
        .off = "OFF",
        .registry = "REGISTRY",
        .registry_and_shadow = "REGISTRY_AND_SHADOW",
    };
};
