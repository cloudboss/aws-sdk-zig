const std = @import("std");

/// Controls what buffer model to use for accurate interleaving. If set to
/// MULTIPLEX, use multiplex buffer model. If set to NONE, this can lead to
/// lower latency, but low-memory devices may not be able to play back the
/// stream without interruptions.
pub const M2tsBufferModel = enum {
    multiplex,
    none,

    pub const json_field_names = .{
        .multiplex = "MULTIPLEX",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .multiplex => "MULTIPLEX",
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
