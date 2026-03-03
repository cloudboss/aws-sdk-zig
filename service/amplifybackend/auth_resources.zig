const std = @import("std");

pub const AuthResources = enum {
    user_pool_only,
    identity_pool_and_user_pool,

    pub const json_field_names = .{
        .user_pool_only = "USER_POOL_ONLY",
        .identity_pool_and_user_pool = "IDENTITY_POOL_AND_USER_POOL",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .user_pool_only => "USER_POOL_ONLY",
            .identity_pool_and_user_pool => "IDENTITY_POOL_AND_USER_POOL",
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
