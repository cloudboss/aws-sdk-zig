pub const JobErrorResourceTypes = enum {
    revision,
    asset,
    data_set,

    pub const json_field_names = .{
        .revision = "REVISION",
        .asset = "ASSET",
        .data_set = "DATA_SET",
    };
};
