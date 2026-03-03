const std = @import("std");

pub const HITReviewStatus = enum {
    not_reviewed,
    marked_for_review,
    reviewed_appropriate,
    reviewed_inappropriate,

    pub const json_field_names = .{
        .not_reviewed = "NotReviewed",
        .marked_for_review = "MarkedForReview",
        .reviewed_appropriate = "ReviewedAppropriate",
        .reviewed_inappropriate = "ReviewedInappropriate",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .not_reviewed => "NotReviewed",
            .marked_for_review => "MarkedForReview",
            .reviewed_appropriate => "ReviewedAppropriate",
            .reviewed_inappropriate => "ReviewedInappropriate",
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
