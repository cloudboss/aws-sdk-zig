pub const CACertificateUpdateAction = enum {
    deactivate,

    pub const json_field_names = .{
        .deactivate = "DEACTIVATE",
    };
};
