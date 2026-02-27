pub const KeyMaterialType = enum {
    tr34_key_block,
    tr31_key_block,
    root_public_key_certificate,
    trusted_public_key_certificate,
    key_cryptogram,

    pub const json_field_names = .{
        .tr34_key_block = "TR34_KEY_BLOCK",
        .tr31_key_block = "TR31_KEY_BLOCK",
        .root_public_key_certificate = "ROOT_PUBLIC_KEY_CERTIFICATE",
        .trusted_public_key_certificate = "TRUSTED_PUBLIC_KEY_CERTIFICATE",
        .key_cryptogram = "KEY_CRYPTOGRAM",
    };
};
