pub const DigitalSignatureMethod = enum {
    jwt_ps384,

    pub const json_field_names = .{
        .jwt_ps384 = "JWT_PS384",
    };
};
