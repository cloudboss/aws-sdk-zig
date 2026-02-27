pub const As2805KeyVariant = enum {
    terminal_major_key_variant_00,
    pin_encryption_key_variant_28,
    message_authentication_key_variant_24,
    data_encryption_key_variant_22,

    pub const json_field_names = .{
        .terminal_major_key_variant_00 = "TERMINAL_MAJOR_KEY_VARIANT_00",
        .pin_encryption_key_variant_28 = "PIN_ENCRYPTION_KEY_VARIANT_28",
        .message_authentication_key_variant_24 = "MESSAGE_AUTHENTICATION_KEY_VARIANT_24",
        .data_encryption_key_variant_22 = "DATA_ENCRYPTION_KEY_VARIANT_22",
    };
};
