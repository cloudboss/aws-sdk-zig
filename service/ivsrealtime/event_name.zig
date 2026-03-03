const std = @import("std");

pub const EventName = enum {
    joined,
    left,
    publish_started,
    publish_stopped,
    subscribe_started,
    subscribe_stopped,
    publish_error,
    subscribe_error,
    join_error,
    replication_started,
    replication_stopped,
    token_exchanged,

    pub const json_field_names = .{
        .joined = "JOINED",
        .left = "LEFT",
        .publish_started = "PUBLISH_STARTED",
        .publish_stopped = "PUBLISH_STOPPED",
        .subscribe_started = "SUBSCRIBE_STARTED",
        .subscribe_stopped = "SUBSCRIBE_STOPPED",
        .publish_error = "PUBLISH_ERROR",
        .subscribe_error = "SUBSCRIBE_ERROR",
        .join_error = "JOIN_ERROR",
        .replication_started = "REPLICATION_STARTED",
        .replication_stopped = "REPLICATION_STOPPED",
        .token_exchanged = "TOKEN_EXCHANGED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .joined => "JOINED",
            .left => "LEFT",
            .publish_started => "PUBLISH_STARTED",
            .publish_stopped => "PUBLISH_STOPPED",
            .subscribe_started => "SUBSCRIBE_STARTED",
            .subscribe_stopped => "SUBSCRIBE_STOPPED",
            .publish_error => "PUBLISH_ERROR",
            .subscribe_error => "SUBSCRIBE_ERROR",
            .join_error => "JOIN_ERROR",
            .replication_started => "REPLICATION_STARTED",
            .replication_stopped => "REPLICATION_STOPPED",
            .token_exchanged => "TOKEN_EXCHANGED",
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
