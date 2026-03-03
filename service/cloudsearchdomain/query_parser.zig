const std = @import("std");

pub const QueryParser = enum {
    simple,
    structured,
    lucene,
    dismax,

    pub const json_field_names = .{
        .simple = "simple",
        .structured = "structured",
        .lucene = "lucene",
        .dismax = "dismax",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .simple => "simple",
            .structured => "structured",
            .lucene => "lucene",
            .dismax => "dismax",
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
