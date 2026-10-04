const std = @import("std");

/// The extraction type for a metadata field, determining how the value is
/// obtained during memory processing.
pub const ExtractionType = enum {
    llm_inferred,
    strictly_consistent,

    pub const json_field_names = .{
        .llm_inferred = "LLM_INFERRED",
        .strictly_consistent = "STRICTLY_CONSISTENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .llm_inferred => "LLM_INFERRED",
            .strictly_consistent => "STRICTLY_CONSISTENT",
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
