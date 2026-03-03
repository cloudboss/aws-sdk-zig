const std = @import("std");

pub const ModelOutputDataFormat = enum {
    csv,
    jsonlines,

    pub const json_field_names = .{
        .csv = "TEXT_CSV",
        .jsonlines = "APPLICATION_JSONLINES",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .csv => "TEXT_CSV",
            .jsonlines => "APPLICATION_JSONLINES",
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
