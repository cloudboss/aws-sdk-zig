const std = @import("std");

pub const FailureType = enum {
    job_failed,
    configuration_error,
    permission_error,
    revision_out_of_sync,
    revision_unavailable,
    system_unavailable,

    pub const json_field_names = .{
        .job_failed = "JobFailed",
        .configuration_error = "ConfigurationError",
        .permission_error = "PermissionError",
        .revision_out_of_sync = "RevisionOutOfSync",
        .revision_unavailable = "RevisionUnavailable",
        .system_unavailable = "SystemUnavailable",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .job_failed => "JobFailed",
            .configuration_error => "ConfigurationError",
            .permission_error => "PermissionError",
            .revision_out_of_sync => "RevisionOutOfSync",
            .revision_unavailable => "RevisionUnavailable",
            .system_unavailable => "SystemUnavailable",
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
