pub const PackageFormat = enum {
    npm,
    pypi,
    maven,
    nuget,
    generic,
    ruby,
    swift,
    cargo,

    pub const json_field_names = .{
        .npm = "NPM",
        .pypi = "PYPI",
        .maven = "MAVEN",
        .nuget = "NUGET",
        .generic = "GENERIC",
        .ruby = "RUBY",
        .swift = "SWIFT",
        .cargo = "CARGO",
    };
};
