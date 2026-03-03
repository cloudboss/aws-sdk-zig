const std = @import("std");

/// Ignore this setting unless you have SCTE-35 markers in your input video
/// file. Choose Passthrough if you want SCTE-35 markers that appear in your
/// input to also appear in this output. Choose None if you don't want those
/// SCTE-35 markers in this output.
pub const MpdScte35Source = enum {
    passthrough,
    none,

    pub const json_field_names = .{
        .passthrough = "PASSTHROUGH",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .passthrough => "PASSTHROUGH",
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
