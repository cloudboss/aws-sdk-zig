pub const BaseModelName = enum {
    narrow_band,
    wide_band,

    pub const json_field_names = .{
        .narrow_band = "NARROW_BAND",
        .wide_band = "WIDE_BAND",
    };
};
