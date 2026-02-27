pub const ProvisionedResourceCleanupSetting = enum {
    automatic,
    off,

    pub const json_field_names = .{
        .automatic = "AUTOMATIC",
        .off = "OFF",
    };
};
