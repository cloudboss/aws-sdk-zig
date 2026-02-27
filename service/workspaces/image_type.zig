pub const ImageType = enum {
    owned,
    shared,

    pub const json_field_names = .{
        .owned = "OWNED",
        .shared = "SHARED",
    };
};
