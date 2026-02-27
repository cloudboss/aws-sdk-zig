pub const AuthDecision = enum {
    allowed,
    explicit_deny,
    implicit_deny,

    pub const json_field_names = .{
        .allowed = "ALLOWED",
        .explicit_deny = "EXPLICIT_DENY",
        .implicit_deny = "IMPLICIT_DENY",
    };
};
