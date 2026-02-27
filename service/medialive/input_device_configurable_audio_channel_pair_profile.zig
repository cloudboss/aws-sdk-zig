/// Property of InputDeviceConfigurableAudioChannelPairConfig, which configures
/// one audio channel that the device produces.
pub const InputDeviceConfigurableAudioChannelPairProfile = enum {
    disabled,
    vbr_aac_hhe_16000,
    vbr_aac_he_64000,
    vbr_aac_lc_128000,
    cbr_aac_hq_192000,
    cbr_aac_hq_256000,
    cbr_aac_hq_384000,
    cbr_aac_hq_512000,

    pub const json_field_names = .{
        .disabled = "DISABLED",
        .vbr_aac_hhe_16000 = "VBR_AAC_HHE_16000",
        .vbr_aac_he_64000 = "VBR_AAC_HE_64000",
        .vbr_aac_lc_128000 = "VBR_AAC_LC_128000",
        .cbr_aac_hq_192000 = "CBR_AAC_HQ_192000",
        .cbr_aac_hq_256000 = "CBR_AAC_HQ_256000",
        .cbr_aac_hq_384000 = "CBR_AAC_HQ_384000",
        .cbr_aac_hq_512000 = "CBR_AAC_HQ_512000",
    };
};
