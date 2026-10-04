const std = @import("std");

pub const ConditionType = enum {
    before_entry,
    on_success,

    pub const json_field_names = .{
        .before_entry = "BEFORE_ENTRY",
        .on_success = "ON_SUCCESS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .before_entry => "BEFORE_ENTRY",
            .on_success => "ON_SUCCESS",
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
