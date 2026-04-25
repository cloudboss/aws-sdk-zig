const std = @import("std");

pub const SessionStatusCode = enum {
    rejected,
    expired,
    configuration_changed,
    all_approvers_in_session,

    pub const json_field_names = .{
        .rejected = "REJECTED",
        .expired = "EXPIRED",
        .configuration_changed = "CONFIGURATION_CHANGED",
        .all_approvers_in_session = "ALL_APPROVERS_IN_SESSION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rejected => "REJECTED",
            .expired => "EXPIRED",
            .configuration_changed => "CONFIGURATION_CHANGED",
            .all_approvers_in_session => "ALL_APPROVERS_IN_SESSION",
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
