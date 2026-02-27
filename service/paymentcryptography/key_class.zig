pub const KeyClass = enum {
    symmetric_key,
    asymmetric_key_pair,
    private_key,
    public_key,

    pub const json_field_names = .{
        .symmetric_key = "SYMMETRIC_KEY",
        .asymmetric_key_pair = "ASYMMETRIC_KEY_PAIR",
        .private_key = "PRIVATE_KEY",
        .public_key = "PUBLIC_KEY",
    };
};
