const std = @import("std");

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
        .vbr_aac_hhe_16000 = "VBR-AAC_HHE-16000",
        .vbr_aac_he_64000 = "VBR-AAC_HE-64000",
        .vbr_aac_lc_128000 = "VBR-AAC_LC-128000",
        .cbr_aac_hq_192000 = "CBR-AAC_HQ-192000",
        .cbr_aac_hq_256000 = "CBR-AAC_HQ-256000",
        .cbr_aac_hq_384000 = "CBR-AAC_HQ-384000",
        .cbr_aac_hq_512000 = "CBR-AAC_HQ-512000",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .disabled => "DISABLED",
            .vbr_aac_hhe_16000 => "VBR-AAC_HHE-16000",
            .vbr_aac_he_64000 => "VBR-AAC_HE-64000",
            .vbr_aac_lc_128000 => "VBR-AAC_LC-128000",
            .cbr_aac_hq_192000 => "CBR-AAC_HQ-192000",
            .cbr_aac_hq_256000 => "CBR-AAC_HQ-256000",
            .cbr_aac_hq_384000 => "CBR-AAC_HQ-384000",
            .cbr_aac_hq_512000 => "CBR-AAC_HQ-512000",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
