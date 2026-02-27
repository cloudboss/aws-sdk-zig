pub const StorageType = enum {
    unlimited,
    quota,

    pub const json_field_names = .{
        .unlimited = "UNLIMITED",
        .quota = "QUOTA",
    };
};
