const std = @import("std");

pub const ActionInvocationType = enum {
    result,
    user_confirmation,
    user_confirmation_and_result,

    pub const json_field_names = .{
        .result = "RESULT",
        .user_confirmation = "USER_CONFIRMATION",
        .user_confirmation_and_result = "USER_CONFIRMATION_AND_RESULT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .result => "RESULT",
            .user_confirmation => "USER_CONFIRMATION",
            .user_confirmation_and_result => "USER_CONFIRMATION_AND_RESULT",
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
