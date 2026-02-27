pub const StorageMaximumSizeUnit = enum {
    mb,
    gb,
    tb,

    pub const json_field_names = .{
        .mb = "MB",
        .gb = "GB",
        .tb = "TB",
    };
};
