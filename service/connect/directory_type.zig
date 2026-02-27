pub const DirectoryType = enum {
    saml,
    connect_managed,
    existing_directory,

    pub const json_field_names = .{
        .saml = "SAML",
        .connect_managed = "CONNECT_MANAGED",
        .existing_directory = "EXISTING_DIRECTORY",
    };
};
