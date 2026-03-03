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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
