pub const AssetModelVersionType = enum {
    latest,
    active,

    pub const json_field_names = .{
        .latest = "LATEST",
        .active = "ACTIVE",
    };
};
