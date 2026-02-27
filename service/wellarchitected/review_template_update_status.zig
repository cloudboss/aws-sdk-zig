pub const ReviewTemplateUpdateStatus = enum {
    current,
    lens_not_current,

    pub const json_field_names = .{
        .current = "CURRENT",
        .lens_not_current = "LENS_NOT_CURRENT",
    };
};
