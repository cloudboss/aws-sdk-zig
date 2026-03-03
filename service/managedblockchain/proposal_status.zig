const std = @import("std");

pub const ProposalStatus = enum {
    in_progress,
    approved,
    rejected,
    expired,
    action_failed,

    pub const json_field_names = .{
        .in_progress = "IN_PROGRESS",
        .approved = "APPROVED",
        .rejected = "REJECTED",
        .expired = "EXPIRED",
        .action_failed = "ACTION_FAILED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .in_progress => "IN_PROGRESS",
            .approved => "APPROVED",
            .rejected => "REJECTED",
            .expired => "EXPIRED",
            .action_failed => "ACTION_FAILED",
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
