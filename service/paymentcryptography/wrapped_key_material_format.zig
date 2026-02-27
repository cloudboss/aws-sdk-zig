pub const WrappedKeyMaterialFormat = enum {
    key_cryptogram,
    tr31_key_block,
    tr34_key_block,

    pub const json_field_names = .{
        .key_cryptogram = "KEY_CRYPTOGRAM",
        .tr31_key_block = "TR31_KEY_BLOCK",
        .tr34_key_block = "TR34_KEY_BLOCK",
    };
};
