const std = @import("std");

pub const Operator = enum {
    eq,
    ne,
    in,
    le,
    lt,
    ge,
    gt,
    contains,
    not_contains,
    begins_with,

    pub const json_field_names = .{
        .eq = "Equals",
        .ne = "NotEquals",
        .in = "In",
        .le = "LessThanOrEqual",
        .lt = "LessThan",
        .ge = "GreaterThanOrEqual",
        .gt = "GreaterThan",
        .contains = "Contains",
        .not_contains = "NotContains",
        .begins_with = "BeginsWith",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .eq => "Equals",
            .ne => "NotEquals",
            .in => "In",
            .le => "LessThanOrEqual",
            .lt => "LessThan",
            .ge => "GreaterThanOrEqual",
            .gt => "GreaterThan",
            .contains => "Contains",
            .not_contains => "NotContains",
            .begins_with => "BeginsWith",
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
