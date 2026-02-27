pub const CaseSensitivity = enum {
    client_specified,
    case_sensitive,

    pub const json_field_names = .{
        .client_specified = "ClientSpecified",
        .case_sensitive = "CaseSensitive",
    };
};
