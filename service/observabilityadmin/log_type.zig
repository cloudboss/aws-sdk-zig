const std = @import("std");

pub const LogType = enum {
    application,
    usage,
    security_finding,
    access,
    connection,

    pub const json_field_names = .{
        .application = "APPLICATION_LOGS",
        .usage = "USAGE_LOGS",
        .security_finding = "SECURITY_FINDING_LOGS",
        .access = "ACCESS_LOGS",
        .connection = "CONNECTION_LOGS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .application => "APPLICATION_LOGS",
            .usage => "USAGE_LOGS",
            .security_finding => "SECURITY_FINDING_LOGS",
            .access => "ACCESS_LOGS",
            .connection => "CONNECTION_LOGS",
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
