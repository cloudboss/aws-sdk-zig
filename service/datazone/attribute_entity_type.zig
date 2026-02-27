pub const AttributeEntityType = enum {
    asset,
    listing,

    pub const json_field_names = .{
        .asset = "ASSET",
        .listing = "LISTING",
    };
};
