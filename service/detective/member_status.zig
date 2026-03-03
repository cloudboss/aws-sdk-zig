const std = @import("std");

pub const MemberStatus = enum {
    invited,
    verification_in_progress,
    verification_failed,
    enabled,
    accepted_but_disabled,

    pub const json_field_names = .{
        .invited = "INVITED",
        .verification_in_progress = "VERIFICATION_IN_PROGRESS",
        .verification_failed = "VERIFICATION_FAILED",
        .enabled = "ENABLED",
        .accepted_but_disabled = "ACCEPTED_BUT_DISABLED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .invited => "INVITED",
            .verification_in_progress => "VERIFICATION_IN_PROGRESS",
            .verification_failed => "VERIFICATION_FAILED",
            .enabled => "ENABLED",
            .accepted_but_disabled => "ACCEPTED_BUT_DISABLED",
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
