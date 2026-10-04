const std = @import("std");

pub const RealTimeContactAnalysisExtractedInformationFailureCode = enum {
    quota_exceeded,
    insufficient_conversation_content,
    failed_safety_guidelines,
    internal_error,
    max_package_feature_only,

    pub const json_field_names = .{
        .quota_exceeded = "QUOTA_EXCEEDED",
        .insufficient_conversation_content = "INSUFFICIENT_CONVERSATION_CONTENT",
        .failed_safety_guidelines = "FAILED_SAFETY_GUIDELINES",
        .internal_error = "INTERNAL_ERROR",
        .max_package_feature_only = "MAX_PACKAGE_FEATURE_ONLY",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .quota_exceeded => "QUOTA_EXCEEDED",
            .insufficient_conversation_content => "INSUFFICIENT_CONVERSATION_CONTENT",
            .failed_safety_guidelines => "FAILED_SAFETY_GUIDELINES",
            .internal_error => "INTERNAL_ERROR",
            .max_package_feature_only => "MAX_PACKAGE_FEATURE_ONLY",
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
