const std = @import("std");

pub const DirectoryUnavailableReason = enum {
    invalid_directory_state,
    directory_timeout,
    directory_resources_exceeded,
    no_disk_space,
    trust_auth_failure,

    pub const json_field_names = .{
        .invalid_directory_state = "INVALID_DIRECTORY_STATE",
        .directory_timeout = "DIRECTORY_TIMEOUT",
        .directory_resources_exceeded = "DIRECTORY_RESOURCES_EXCEEDED",
        .no_disk_space = "NO_DISK_SPACE",
        .trust_auth_failure = "TRUST_AUTH_FAILURE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invalid_directory_state => "INVALID_DIRECTORY_STATE",
            .directory_timeout => "DIRECTORY_TIMEOUT",
            .directory_resources_exceeded => "DIRECTORY_RESOURCES_EXCEEDED",
            .no_disk_space => "NO_DISK_SPACE",
            .trust_auth_failure => "TRUST_AUTH_FAILURE",
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
