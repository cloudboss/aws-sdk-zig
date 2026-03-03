const std = @import("std");

pub const ComparisonOperator = enum {
    eq,
    ne,
    le,
    lt,
    ge,
    gt,

    pub const json_field_names = .{
        .eq = "EQ",
        .ne = "NE",
        .le = "LE",
        .lt = "LT",
        .ge = "GE",
        .gt = "GT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .eq => "EQ",
            .ne => "NE",
            .le => "LE",
            .lt => "LT",
            .ge => "GE",
            .gt => "GT",
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
