const std = @import("std");

pub const ExecutionErrorType = enum {
    permission_denied,
    custom_step_failed,
    throttled,
    already_exists,
    not_found,
    bad_request,
    timeout,
    internal_server_error,

    pub const json_field_names = .{
        .permission_denied = "PERMISSION_DENIED",
        .custom_step_failed = "CUSTOM_STEP_FAILED",
        .throttled = "THROTTLED",
        .already_exists = "ALREADY_EXISTS",
        .not_found = "NOT_FOUND",
        .bad_request = "BAD_REQUEST",
        .timeout = "TIMEOUT",
        .internal_server_error = "INTERNAL_SERVER_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .permission_denied => "PERMISSION_DENIED",
            .custom_step_failed => "CUSTOM_STEP_FAILED",
            .throttled => "THROTTLED",
            .already_exists => "ALREADY_EXISTS",
            .not_found => "NOT_FOUND",
            .bad_request => "BAD_REQUEST",
            .timeout => "TIMEOUT",
            .internal_server_error => "INTERNAL_SERVER_ERROR",
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
