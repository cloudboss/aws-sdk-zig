const std = @import("std");

pub const WordCloudWordCasing = enum {
    lower_case,
    existing_case,

    pub const json_field_names = .{
        .lower_case = "LOWER_CASE",
        .existing_case = "EXISTING_CASE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .lower_case => "LOWER_CASE",
            .existing_case => "EXISTING_CASE",
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
