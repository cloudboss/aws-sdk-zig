const std = @import("std");

pub const OperatorType = enum {
    eq,
    lt,
    gt,
    le,
    ge,
    in,
    between,

    pub const json_field_names = .{
        .eq = "eq",
        .lt = "lt",
        .gt = "gt",
        .le = "le",
        .ge = "ge",
        .in = "in",
        .between = "between",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .eq => "eq",
            .lt => "lt",
            .gt => "gt",
            .le => "le",
            .ge => "ge",
            .in => "in",
            .between => "between",
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
