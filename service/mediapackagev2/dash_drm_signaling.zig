pub const DashDrmSignaling = enum {
    individual,
    referenced,

    pub const json_field_names = .{
        .individual = "INDIVIDUAL",
        .referenced = "REFERENCED",
    };
};
