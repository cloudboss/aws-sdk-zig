pub const ExistingEnrollmentAction = enum {
    skip,
    overwrite,

    pub const json_field_names = .{
        .skip = "SKIP",
        .overwrite = "OVERWRITE",
    };
};
