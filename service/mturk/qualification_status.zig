pub const QualificationStatus = enum {
    granted,
    revoked,

    pub const json_field_names = .{
        .granted = "Granted",
        .revoked = "Revoked",
    };
};
