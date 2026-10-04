const std = @import("std");

pub const ApplicationRevisionSortBy = enum {
    register_time,
    first_used_time,
    last_used_time,

    pub const json_field_names = .{
        .register_time = "registerTime",
        .first_used_time = "firstUsedTime",
        .last_used_time = "lastUsedTime",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .register_time => "registerTime",
            .first_used_time => "firstUsedTime",
            .last_used_time => "lastUsedTime",
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
