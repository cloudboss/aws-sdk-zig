pub const Terrain = enum {
    hillshade,
    terrain_3_d,

    pub const json_field_names = .{
        .hillshade = "HILLSHADE",
        .terrain_3_d = "TERRAIN_3D",
    };
};
