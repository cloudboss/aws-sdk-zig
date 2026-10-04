const std = @import("std");

pub const ExistCondition = enum {
    must_exist,
    not_exist,
    none,

    pub const json_field_names = .{
        .must_exist = "MUST_EXIST",
        .not_exist = "NOT_EXIST",
        .none = "NONE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .must_exist => "MUST_EXIST",
            .not_exist => "NOT_EXIST",
            .none => "NONE",
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
