pub const SsmParameterStoreParameterType = enum {
    string,
    secure_string,

    pub const json_field_names = .{
        .string = "STRING",
        .secure_string = "SECURE_STRING",
    };
};
