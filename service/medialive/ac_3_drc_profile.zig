/// Ac3 Drc Profile
pub const Ac3DrcProfile = enum {
    film_standard,
    none,

    pub const json_field_names = .{
        .film_standard = "FILM_STANDARD",
        .none = "NONE",
    };
};
