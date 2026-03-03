const std = @import("std");

pub const RealTimeAlertRuleType = enum {
    keyword_match,
    sentiment,
    issue_detection,

    pub const json_field_names = .{
        .keyword_match = "KeywordMatch",
        .sentiment = "Sentiment",
        .issue_detection = "IssueDetection",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .keyword_match => "KeywordMatch",
            .sentiment => "Sentiment",
            .issue_detection => "IssueDetection",
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
