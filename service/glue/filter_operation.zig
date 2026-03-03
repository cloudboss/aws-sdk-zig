const std = @import("std");

pub const FilterOperation = enum {
    eq,
    lt,
    gt,
    lte,
    gte,
    regex,
    isnull,

    pub const json_field_names = .{
        .eq = "EQ",
        .lt = "LT",
        .gt = "GT",
        .lte = "LTE",
        .gte = "GTE",
        .regex = "REGEX",
        .isnull = "ISNULL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .eq => "EQ",
            .lt => "LT",
            .gt => "GT",
            .lte => "LTE",
            .gte => "GTE",
            .regex => "REGEX",
            .isnull => "ISNULL",
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
