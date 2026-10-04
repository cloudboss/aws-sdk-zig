const std = @import("std");

pub const RealTimeContactAnalysisSegmentType = enum {
    transcript,
    categories,
    issues,
    event,
    attachments,
    post_contact_summary,
    extracted_information,

    pub const json_field_names = .{
        .transcript = "Transcript",
        .categories = "Categories",
        .issues = "Issues",
        .event = "Event",
        .attachments = "Attachments",
        .post_contact_summary = "PostContactSummary",
        .extracted_information = "ExtractedInformation",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .transcript => "Transcript",
            .categories => "Categories",
            .issues => "Issues",
            .event => "Event",
            .attachments => "Attachments",
            .post_contact_summary => "PostContactSummary",
            .extracted_information => "ExtractedInformation",
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
