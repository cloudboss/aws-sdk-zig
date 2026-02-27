pub const KeyAgreementAlgorithmSpec = enum {
    ecdh,

    pub const json_field_names = .{
        .ecdh = "ECDH",
    };
};
