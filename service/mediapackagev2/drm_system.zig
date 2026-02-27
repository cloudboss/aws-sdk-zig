pub const DrmSystem = enum {
    clear_key_aes_128,
    fairplay,
    playready,
    widevine,
    irdeto,

    pub const json_field_names = .{
        .clear_key_aes_128 = "CLEAR_KEY_AES_128",
        .fairplay = "FAIRPLAY",
        .playready = "PLAYREADY",
        .widevine = "WIDEVINE",
        .irdeto = "IRDETO",
    };
};
