const std = @import("std");

/// The error code for a connector health issue.
pub const HealthIssueCode = enum {
    authentication_failure,
    stream_authorization_failure,
    discovery_failure,
    stream_limit_exceeded,
    stream_disconnected,
    recording_failure,
    no_health_data,

    pub const json_field_names = .{
        .authentication_failure = "AUTHENTICATION_FAILURE",
        .stream_authorization_failure = "STREAM_AUTHORIZATION_FAILURE",
        .discovery_failure = "DISCOVERY_FAILURE",
        .stream_limit_exceeded = "STREAM_LIMIT_EXCEEDED",
        .stream_disconnected = "STREAM_DISCONNECTED",
        .recording_failure = "RECORDING_FAILURE",
        .no_health_data = "NO_HEALTH_DATA",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .authentication_failure => "AUTHENTICATION_FAILURE",
            .stream_authorization_failure => "STREAM_AUTHORIZATION_FAILURE",
            .discovery_failure => "DISCOVERY_FAILURE",
            .stream_limit_exceeded => "STREAM_LIMIT_EXCEEDED",
            .stream_disconnected => "STREAM_DISCONNECTED",
            .recording_failure => "RECORDING_FAILURE",
            .no_health_data => "NO_HEALTH_DATA",
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
