const std = @import("std");

pub const EvaluationStatus = enum {
    draft,
    submitted,
    review_requested,
    under_review,

    pub const json_field_names = .{
        .draft = "DRAFT",
        .submitted = "SUBMITTED",
        .review_requested = "REVIEW_REQUESTED",
        .under_review = "UNDER_REVIEW",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .draft => "DRAFT",
            .submitted => "SUBMITTED",
            .review_requested => "REVIEW_REQUESTED",
            .under_review => "UNDER_REVIEW",
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
