const std = @import("std");

pub const AdMarkers = enum {
    none,
    scte35_enhanced,
    passthrough,
    daterange,

    pub const json_field_names = .{
        .none = "NONE",
        .scte35_enhanced = "SCTE35_ENHANCED",
        .passthrough = "PASSTHROUGH",
        .daterange = "DATERANGE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .scte35_enhanced => "SCTE35_ENHANCED",
            .passthrough => "PASSTHROUGH",
            .daterange => "DATERANGE",
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
