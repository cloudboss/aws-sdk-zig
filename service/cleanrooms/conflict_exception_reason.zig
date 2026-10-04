const std = @import("std");

pub const ConflictExceptionReason = enum {
    already_exists,
    subresources_exist,
    invalid_state,

    pub const json_field_names = .{
        .already_exists = "ALREADY_EXISTS",
        .subresources_exist = "SUBRESOURCES_EXIST",
        .invalid_state = "INVALID_STATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .already_exists => "ALREADY_EXISTS",
            .subresources_exist => "SUBRESOURCES_EXIST",
            .invalid_state => "INVALID_STATE",
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
