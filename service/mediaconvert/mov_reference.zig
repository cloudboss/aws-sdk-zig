/// Always keep the default value (SELF_CONTAINED) for this setting.
pub const MovReference = enum {
    self_contained,
    external,

    pub const json_field_names = .{
        .self_contained = "SELF_CONTAINED",
        .external = "EXTERNAL",
    };
};
