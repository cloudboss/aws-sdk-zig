pub const MultiRegionConsistency = enum {
    eventual,
    strong,

    pub const json_field_names = .{
        .eventual = "EVENTUAL",
        .strong = "STRONG",
    };
};
