const std = @import("std");

/// COMBINE_DUPLICATE_STREAMS combines identical audio encoding settings across
/// a Microsoft Smooth output group into a single audio stream.
pub const MsSmoothAudioDeduplication = enum {
    combine_duplicate_streams,
    none,

    pub const json_field_names = .{
        .combine_duplicate_streams = "COMBINE_DUPLICATE_STREAMS",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .combine_duplicate_streams => "COMBINE_DUPLICATE_STREAMS",
            .none => "NONE",
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
