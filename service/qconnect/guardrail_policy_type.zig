const std = @import("std");

/// Classification of a guardrail policy.
pub const GuardrailPolicyType = enum {
    content_filter,
    topic,
    word,
    sensitive_information_pii,
    sensitive_information_regex,
    contextual_grounding,

    pub const json_field_names = .{
        .content_filter = "CONTENT_FILTER",
        .topic = "TOPIC",
        .word = "WORD",
        .sensitive_information_pii = "SENSITIVE_INFORMATION_PII",
        .sensitive_information_regex = "SENSITIVE_INFORMATION_REGEX",
        .contextual_grounding = "CONTEXTUAL_GROUNDING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .content_filter => "CONTENT_FILTER",
            .topic => "TOPIC",
            .word => "WORD",
            .sensitive_information_pii => "SENSITIVE_INFORMATION_PII",
            .sensitive_information_regex => "SENSITIVE_INFORMATION_REGEX",
            .contextual_grounding => "CONTEXTUAL_GROUNDING",
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
