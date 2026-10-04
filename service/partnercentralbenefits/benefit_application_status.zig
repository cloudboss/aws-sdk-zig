const std = @import("std");

pub const BenefitApplicationStatus = enum {
    pending_submission,
    in_review,
    action_required,
    approved,
    rejected,
    canceled,

    pub const json_field_names = .{
        .pending_submission = "PENDING_SUBMISSION",
        .in_review = "IN_REVIEW",
        .action_required = "ACTION_REQUIRED",
        .approved = "APPROVED",
        .rejected = "REJECTED",
        .canceled = "CANCELED",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_submission => "PENDING_SUBMISSION",
            .in_review => "IN_REVIEW",
            .action_required => "ACTION_REQUIRED",
            .approved => "APPROVED",
            .rejected => "REJECTED",
            .canceled => "CANCELED",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        const fields = @typeInfo(@TypeOf(json_field_names)).@"struct".field_names;
        inline for (fields) |field_name| {
            if (std.mem.eql(u8, str, @field(json_field_names, field_name))) {
                return @field(@This(), field_name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
