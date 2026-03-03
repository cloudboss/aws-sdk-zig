const std = @import("std");

pub const LogExport = enum {
    user_activity_log,
    user_log,
    connection_log,

    pub const json_field_names = .{
        .user_activity_log = "useractivitylog",
        .user_log = "userlog",
        .connection_log = "connectionlog",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .user_activity_log => "useractivitylog",
            .user_log => "userlog",
            .connection_log => "connectionlog",
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
