const std = @import("std");

pub const RealTimeContactAnalysisSegmentType = enum {
    transcript,
    categories,
    issues,
    event,
    attachments,
    post_contact_summary,

    pub const json_field_names = .{
        .transcript = "Transcript",
        .categories = "Categories",
        .issues = "Issues",
        .event = "Event",
        .attachments = "Attachments",
        .post_contact_summary = "PostContactSummary",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .transcript => "Transcript",
            .categories => "Categories",
            .issues => "Issues",
            .event => "Event",
            .attachments => "Attachments",
            .post_contact_summary => "PostContactSummary",
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
