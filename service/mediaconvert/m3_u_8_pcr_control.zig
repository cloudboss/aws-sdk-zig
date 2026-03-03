const std = @import("std");

/// When set to PCR_EVERY_PES_PACKET a Program Clock Reference value is inserted
/// for every Packetized Elementary Stream (PES) header. This parameter is
/// effective only when the PCR PID is the same as the video or audio elementary
/// stream.
pub const M3u8PcrControl = enum {
    pcr_every_pes_packet,
    configured_pcr_period,

    pub const json_field_names = .{
        .pcr_every_pes_packet = "PCR_EVERY_PES_PACKET",
        .configured_pcr_period = "CONFIGURED_PCR_PERIOD",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pcr_every_pes_packet => "PCR_EVERY_PES_PACKET",
            .configured_pcr_period => "CONFIGURED_PCR_PERIOD",
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
