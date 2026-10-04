const std = @import("std");

pub const ThreatIntelSetFormat = enum {
    txt,
    stix,
    otx_csv,
    alien_vault,
    proof_point,
    fire_eye,

    pub const json_field_names = .{
        .txt = "TXT",
        .stix = "STIX",
        .otx_csv = "OTX_CSV",
        .alien_vault = "ALIEN_VAULT",
        .proof_point = "PROOF_POINT",
        .fire_eye = "FIRE_EYE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .txt => "TXT",
            .stix => "STIX",
            .otx_csv => "OTX_CSV",
            .alien_vault => "ALIEN_VAULT",
            .proof_point => "PROOF_POINT",
            .fire_eye => "FIRE_EYE",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
