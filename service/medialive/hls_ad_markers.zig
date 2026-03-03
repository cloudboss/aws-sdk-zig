const std = @import("std");

/// Hls Ad Markers
pub const HlsAdMarkers = enum {
    adobe,
    elemental,
    elemental_scte35,

    pub const json_field_names = .{
        .adobe = "ADOBE",
        .elemental = "ELEMENTAL",
        .elemental_scte35 = "ELEMENTAL_SCTE35",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .adobe => "ADOBE",
            .elemental => "ELEMENTAL",
            .elemental_scte35 => "ELEMENTAL_SCTE35",
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
