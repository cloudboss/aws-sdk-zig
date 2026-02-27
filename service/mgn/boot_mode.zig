pub const BootMode = enum {
    legacy_bios,
    uefi,
    use_source,

    pub const json_field_names = .{
        .legacy_bios = "LEGACY_BIOS",
        .uefi = "UEFI",
        .use_source = "USE_SOURCE",
    };
};
