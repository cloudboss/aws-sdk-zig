pub const EncryptionOption = enum {
    ao_cmk,
    cm_cmk,

    pub const json_field_names = .{
        .ao_cmk = "AoCmk",
        .cm_cmk = "CmCmk",
    };
};
