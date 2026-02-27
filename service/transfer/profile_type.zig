pub const ProfileType = enum {
    local,
    partner,

    pub const json_field_names = .{
        .local = "LOCAL",
        .partner = "PARTNER",
    };
};
