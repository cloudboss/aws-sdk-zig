const std = @import("std");

pub const SubscriptionGrantOverallStatus = enum {
    pending,
    in_progress,
    grant_failed,
    revoke_failed,
    grant_and_revoke_failed,
    completed,
    inaccessible,

    pub const json_field_names = .{
        .pending = "PENDING",
        .in_progress = "IN_PROGRESS",
        .grant_failed = "GRANT_FAILED",
        .revoke_failed = "REVOKE_FAILED",
        .grant_and_revoke_failed = "GRANT_AND_REVOKE_FAILED",
        .completed = "COMPLETED",
        .inaccessible = "INACCESSIBLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending => "PENDING",
            .in_progress => "IN_PROGRESS",
            .grant_failed => "GRANT_FAILED",
            .revoke_failed => "REVOKE_FAILED",
            .grant_and_revoke_failed => "GRANT_AND_REVOKE_FAILED",
            .completed => "COMPLETED",
            .inaccessible => "INACCESSIBLE",
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
