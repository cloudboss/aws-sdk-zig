pub const UserVerificationType = enum {
    required,
    preferred,

    pub const json_field_names = .{
        .required = "REQUIRED",
        .preferred = "PREFERRED",
    };
};
