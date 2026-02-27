pub const DiskImageFormat = enum {
    vmdk,
    raw,
    vhd,

    pub const json_field_names = .{
        .vmdk = "VMDK",
        .raw = "RAW",
        .vhd = "VHD",
    };
};
