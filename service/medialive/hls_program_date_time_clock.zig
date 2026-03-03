const std = @import("std");

/// Hls Program Date Time Clock
pub const HlsProgramDateTimeClock = enum {
    initialize_from_output_timecode,
    system_clock,

    pub const json_field_names = .{
        .initialize_from_output_timecode = "INITIALIZE_FROM_OUTPUT_TIMECODE",
        .system_clock = "SYSTEM_CLOCK",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .initialize_from_output_timecode => "INITIALIZE_FROM_OUTPUT_TIMECODE",
            .system_clock => "SYSTEM_CLOCK",
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
