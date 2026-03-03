const std = @import("std");

pub const TargetHealthReason = enum {
    @"unreachable",
    connection_failed,
    auth_failure,
    pending_proxy_capacity,
    invalid_replication_state,
    promoted,

    pub const json_field_names = .{
        .@"unreachable" = "UNREACHABLE",
        .connection_failed = "CONNECTION_FAILED",
        .auth_failure = "AUTH_FAILURE",
        .pending_proxy_capacity = "PENDING_PROXY_CAPACITY",
        .invalid_replication_state = "INVALID_REPLICATION_STATE",
        .promoted = "PROMOTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .@"unreachable" => "UNREACHABLE",
            .connection_failed => "CONNECTION_FAILED",
            .auth_failure => "AUTH_FAILURE",
            .pending_proxy_capacity => "PENDING_PROXY_CAPACITY",
            .invalid_replication_state => "INVALID_REPLICATION_STATE",
            .promoted => "PROMOTED",
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
