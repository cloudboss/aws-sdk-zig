pub const ProviderType = enum {
    github,
    bitbucket,

    pub const json_field_names = .{
        .github = "GITHUB",
        .bitbucket = "BITBUCKET",
    };
};
