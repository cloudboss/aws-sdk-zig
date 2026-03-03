const std = @import("std");

/// M2ts Pcr Control
pub const M2tsPcrControl = enum {
    configured_pcr_period,
    pcr_every_pes_packet,

    pub const json_field_names = .{
        .configured_pcr_period = "CONFIGURED_PCR_PERIOD",
        .pcr_every_pes_packet = "PCR_EVERY_PES_PACKET",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .configured_pcr_period => "CONFIGURED_PCR_PERIOD",
            .pcr_every_pes_packet => "PCR_EVERY_PES_PACKET",
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
