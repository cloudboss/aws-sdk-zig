const std = @import("std");

/// Controls the source of position and style information for embedded outputs.
/// - "passthrough": Carry the caption position and style from the source
/// captions. When the source captions are embedded, SCTE-20, or ancillary, the
/// position and style are preserved exactly. When the source captions are
/// another format, the position and any supported style are carried over.
/// - "manual": Use the position specified in the destination's position field.
pub const EmbeddedDestinationStyleControl = enum {
    manual,
    passthrough,

    pub const json_field_names = .{
        .manual = "MANUAL",
        .passthrough = "PASSTHROUGH",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .manual => "MANUAL",
            .passthrough => "PASSTHROUGH",
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
