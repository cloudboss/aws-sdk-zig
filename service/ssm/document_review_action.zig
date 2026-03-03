const std = @import("std");

pub const DocumentReviewAction = enum {
    send_for_review,
    update_review,
    approve,
    reject,

    pub const json_field_names = .{
        .send_for_review = "SendForReview",
        .update_review = "UpdateReview",
        .approve = "Approve",
        .reject = "Reject",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .send_for_review => "SendForReview",
            .update_review => "UpdateReview",
            .approve => "Approve",
            .reject => "Reject",
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
