pub const OAuthGrantType = enum {
    code,
    implicit,

    pub const json_field_names = .{
        .code = "CODE",
        .implicit = "IMPLICIT",
    };
};
