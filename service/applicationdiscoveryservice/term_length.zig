const std = @import("std");

pub const TermLength = enum {
    one_year,
    three_year,

    pub const json_field_names = .{
        .one_year = "ONE_YEAR",
        .three_year = "THREE_YEAR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .one_year => "ONE_YEAR",
            .three_year => "THREE_YEAR",
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
