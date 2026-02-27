pub const CustomImageProtocol = enum {
    pcoip,
    dcv,
    byop,

    pub const json_field_names = .{
        .pcoip = "PCOIP",
        .dcv = "DCV",
        .byop = "BYOP",
    };
};
