const std = @import("std");

pub const PostContactSummaryFailureCode = enum {
    quota_exceeded,
    insufficient_conversation_content,
    failed_safety_guidelines,
    invalid_analysis_configuration,
    internal_error,

    pub const json_field_names = .{
        .quota_exceeded = "QUOTA_EXCEEDED",
        .insufficient_conversation_content = "INSUFFICIENT_CONVERSATION_CONTENT",
        .failed_safety_guidelines = "FAILED_SAFETY_GUIDELINES",
        .invalid_analysis_configuration = "INVALID_ANALYSIS_CONFIGURATION",
        .internal_error = "INTERNAL_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .quota_exceeded => "QUOTA_EXCEEDED",
            .insufficient_conversation_content => "INSUFFICIENT_CONVERSATION_CONTENT",
            .failed_safety_guidelines => "FAILED_SAFETY_GUIDELINES",
            .invalid_analysis_configuration => "INVALID_ANALYSIS_CONFIGURATION",
            .internal_error => "INTERNAL_ERROR",
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
