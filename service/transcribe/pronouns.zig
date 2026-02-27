pub const Pronouns = enum {
    he_him,
    she_her,
    they_them,

    pub const json_field_names = .{
        .he_him = "HE_HIM",
        .she_her = "SHE_HER",
        .they_them = "THEY_THEM",
    };
};
