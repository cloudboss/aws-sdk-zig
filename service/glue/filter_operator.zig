const std = @import("std");

pub const FilterOperator = enum {
    gt,
    ge,
    lt,
    le,
    eq,
    ne,

    pub const json_field_names = .{
        .gt = "GT",
        .ge = "GE",
        .lt = "LT",
        .le = "LE",
        .eq = "EQ",
        .ne = "NE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .gt => "GT",
            .ge => "GE",
            .lt => "LT",
            .le => "LE",
            .eq => "EQ",
            .ne => "NE",
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
