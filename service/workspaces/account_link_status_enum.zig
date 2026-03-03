const std = @import("std");

pub const AccountLinkStatusEnum = enum {
    linked,
    linking_failed,
    link_not_found,
    pending_acceptance_by_target_account,
    rejected,

    pub const json_field_names = .{
        .linked = "LINKED",
        .linking_failed = "LINKING_FAILED",
        .link_not_found = "LINK_NOT_FOUND",
        .pending_acceptance_by_target_account = "PENDING_ACCEPTANCE_BY_TARGET_ACCOUNT",
        .rejected = "REJECTED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .linked => "LINKED",
            .linking_failed => "LINKING_FAILED",
            .link_not_found => "LINK_NOT_FOUND",
            .pending_acceptance_by_target_account => "PENDING_ACCEPTANCE_BY_TARGET_ACCOUNT",
            .rejected => "REJECTED",
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
