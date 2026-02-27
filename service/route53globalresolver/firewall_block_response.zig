pub const FirewallBlockResponse = enum {
    nodata,
    nxdomain,
    override,

    pub const json_field_names = .{
        .nodata = "NODATA",
        .nxdomain = "NXDOMAIN",
        .override = "OVERRIDE",
    };
};
