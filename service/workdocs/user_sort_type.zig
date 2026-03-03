const std = @import("std");

pub const UserSortType = enum {
    user_name,
    full_name,
    storage_limit,
    user_status,
    storage_used,

    pub const json_field_names = .{
        .user_name = "USER_NAME",
        .full_name = "FULL_NAME",
        .storage_limit = "STORAGE_LIMIT",
        .user_status = "USER_STATUS",
        .storage_used = "STORAGE_USED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .user_name => "USER_NAME",
            .full_name => "FULL_NAME",
            .storage_limit => "STORAGE_LIMIT",
            .user_status => "USER_STATUS",
            .storage_used => "STORAGE_USED",
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
