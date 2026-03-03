const std = @import("std");

pub const StreamSessionStatusReason = enum {
    internal_error,
    invalid_signal_request,
    placement_timeout,
    app_log_s3_destination_error,
    application_exit,
    connection_timeout,
    reconnection_timeout,
    max_session_length_timeout,
    idle_timeout,
    api_terminated,

    pub const json_field_names = .{
        .internal_error = "internalError",
        .invalid_signal_request = "invalidSignalRequest",
        .placement_timeout = "placementTimeout",
        .app_log_s3_destination_error = "applicationLogS3DestinationError",
        .application_exit = "applicationExit",
        .connection_timeout = "connectionTimeout",
        .reconnection_timeout = "reconnectionTimeout",
        .max_session_length_timeout = "maxSessionLengthTimeout",
        .idle_timeout = "idleTimeout",
        .api_terminated = "apiTerminated",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .internal_error => "internalError",
            .invalid_signal_request => "invalidSignalRequest",
            .placement_timeout => "placementTimeout",
            .app_log_s3_destination_error => "applicationLogS3DestinationError",
            .application_exit => "applicationExit",
            .connection_timeout => "connectionTimeout",
            .reconnection_timeout => "reconnectionTimeout",
            .max_session_length_timeout => "maxSessionLengthTimeout",
            .idle_timeout => "idleTimeout",
            .api_terminated => "apiTerminated",
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
