pub const DuplicateRegistrationAction = enum {
    skip,
    register_as_new,

    pub const json_field_names = .{
        .skip = "SKIP",
        .register_as_new = "REGISTER_AS_NEW",
    };
};
