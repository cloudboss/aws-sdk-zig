const std = @import("std");

pub const InsightType = enum {
    api_call_rate_insight,
    api_error_rate_insight,

    pub const json_field_names = .{
        .api_call_rate_insight = "ApiCallRateInsight",
        .api_error_rate_insight = "ApiErrorRateInsight",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .api_call_rate_insight => "ApiCallRateInsight",
            .api_error_rate_insight => "ApiErrorRateInsight",
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
