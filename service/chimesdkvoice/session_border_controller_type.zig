const std = @import("std");

pub const SessionBorderControllerType = enum {
    ribbon_sbc,
    oracle_acme_packet_sbc,
    avaya_sbce,
    cisco_unified_border_element,
    audiocodes_mediant_sbc,

    pub const json_field_names = .{
        .ribbon_sbc = "RIBBON_SBC",
        .oracle_acme_packet_sbc = "ORACLE_ACME_PACKET_SBC",
        .avaya_sbce = "AVAYA_SBCE",
        .cisco_unified_border_element = "CISCO_UNIFIED_BORDER_ELEMENT",
        .audiocodes_mediant_sbc = "AUDIOCODES_MEDIANT_SBC",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ribbon_sbc => "RIBBON_SBC",
            .oracle_acme_packet_sbc => "ORACLE_ACME_PACKET_SBC",
            .avaya_sbce => "AVAYA_SBCE",
            .cisco_unified_border_element => "CISCO_UNIFIED_BORDER_ELEMENT",
            .audiocodes_mediant_sbc => "AUDIOCODES_MEDIANT_SBC",
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
