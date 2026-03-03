const std = @import("std");

/// If INSERT, Nielsen inaudible tones for media tracking will be detected in
/// the input audio and an equivalent ID3 tag will be inserted in the output.
pub const M2tsNielsenId3 = enum {
    insert,
    none,

    pub const json_field_names = .{
        .insert = "INSERT",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .insert => "INSERT",
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
