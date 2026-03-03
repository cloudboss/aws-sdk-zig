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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
