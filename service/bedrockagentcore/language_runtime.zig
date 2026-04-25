const std = @import("std");

pub const LanguageRuntime = enum {
    nodejs,
    deno,
    python,

    pub const json_field_names = .{
        .nodejs = "nodejs",
        .deno = "deno",
        .python = "python",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .nodejs => "nodejs",
            .deno => "deno",
            .python => "python",
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
