pub const TrustType = enum {
    forest,
    external,

    pub const json_field_names = .{
        .forest = "FOREST",
        .external = "EXTERNAL",
    };
};
