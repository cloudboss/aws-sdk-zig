pub const MssManifestLayout = enum {
    full,
    compact,

    pub const json_field_names = .{
        .full = "FULL",
        .compact = "COMPACT",
    };
};
