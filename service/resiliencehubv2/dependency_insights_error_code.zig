const std = @import("std");

pub const DependencyInsightsErrorCode = enum {
    insufficient_data,
    llm_generation_failed,
    internal_error,

    pub const json_field_names = .{
        .insufficient_data = "INSUFFICIENT_DATA",
        .llm_generation_failed = "LLM_GENERATION_FAILED",
        .internal_error = "INTERNAL_ERROR",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .insufficient_data => "INSUFFICIENT_DATA",
            .llm_generation_failed => "LLM_GENERATION_FAILED",
            .internal_error => "INTERNAL_ERROR",
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
