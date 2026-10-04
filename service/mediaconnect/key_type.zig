const std = @import("std");

pub const KeyType = enum {
    speke,
    static_key,
    srt_password,

    pub const json_field_names = .{
        .speke = "speke",
        .static_key = "static-key",
        .srt_password = "srt-password",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .speke => "speke",
            .static_key => "static-key",
            .srt_password => "srt-password",
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
