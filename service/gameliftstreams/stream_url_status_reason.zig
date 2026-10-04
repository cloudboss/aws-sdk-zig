const std = @import("std");

pub const StreamUrlStatusReason = enum {
    user_revoked,
    revoked_and_terminating_sessions,
    revoked_and_sessions_terminated,
    stream_group_deleted,
    application_deleted,

    pub const json_field_names = .{
        .user_revoked = "userRevoked",
        .revoked_and_terminating_sessions = "revokedAndTerminatingSessions",
        .revoked_and_sessions_terminated = "revokedAndSessionsTerminated",
        .stream_group_deleted = "streamGroupDeleted",
        .application_deleted = "applicationDeleted",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .user_revoked => "userRevoked",
            .revoked_and_terminating_sessions => "revokedAndTerminatingSessions",
            .revoked_and_sessions_terminated => "revokedAndSessionsTerminated",
            .stream_group_deleted => "streamGroupDeleted",
            .application_deleted => "applicationDeleted",
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
