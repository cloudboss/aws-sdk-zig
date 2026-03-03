const std = @import("std");

pub const ExecutionRoleIdentityConfig = enum {
    user_profile_name,
    disabled,

    pub const json_field_names = .{
        .user_profile_name = "USER_PROFILE_NAME",
        .disabled = "DISABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .user_profile_name => "USER_PROFILE_NAME",
            .disabled => "DISABLED",
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
