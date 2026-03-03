const std = @import("std");

pub const ReviewStatus = enum {
    pending_submission,
    submitted,
    in_review,
    approved,
    rejected,
    action_required,

    pub const json_field_names = .{
        .pending_submission = "Pending Submission",
        .submitted = "Submitted",
        .in_review = "In review",
        .approved = "Approved",
        .rejected = "Rejected",
        .action_required = "Action Required",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .pending_submission => "Pending Submission",
            .submitted => "Submitted",
            .in_review => "In review",
            .approved => "Approved",
            .rejected => "Rejected",
            .action_required => "Action Required",
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
