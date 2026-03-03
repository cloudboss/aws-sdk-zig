const std = @import("std");

/// Ad marker for Apple HLS manifest.
pub const HlsAdMarkers = enum {
    elemental,
    elemental_scte35,

    pub const json_field_names = .{
        .elemental = "ELEMENTAL",
        .elemental_scte35 = "ELEMENTAL_SCTE35",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
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
