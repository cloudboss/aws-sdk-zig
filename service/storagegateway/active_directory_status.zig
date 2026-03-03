const std = @import("std");

pub const ActiveDirectoryStatus = enum {
    access_denied,
    detached,
    joined,
    joining,
    network_error,
    timeout,
    unknown_error,
    insufficient_permissions,

    pub const json_field_names = .{
        .access_denied = "ACCESS_DENIED",
        .detached = "DETACHED",
        .joined = "JOINED",
        .joining = "JOINING",
        .network_error = "NETWORK_ERROR",
        .timeout = "TIMEOUT",
        .unknown_error = "UNKNOWN_ERROR",
        .insufficient_permissions = "INSUFFICIENT_PERMISSIONS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .access_denied => "ACCESS_DENIED",
            .detached => "DETACHED",
            .joined => "JOINED",
            .joining => "JOINING",
            .network_error => "NETWORK_ERROR",
            .timeout => "TIMEOUT",
            .unknown_error => "UNKNOWN_ERROR",
            .insufficient_permissions => "INSUFFICIENT_PERMISSIONS",
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
