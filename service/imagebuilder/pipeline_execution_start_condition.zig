const std = @import("std");

pub const PipelineExecutionStartCondition = enum {
    expression_match_only,
    expression_match_and_dependency_updates_available,

    pub const json_field_names = .{
        .expression_match_only = "EXPRESSION_MATCH_ONLY",
        .expression_match_and_dependency_updates_available = "EXPRESSION_MATCH_AND_DEPENDENCY_UPDATES_AVAILABLE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .expression_match_only => "EXPRESSION_MATCH_ONLY",
            .expression_match_and_dependency_updates_available => "EXPRESSION_MATCH_AND_DEPENDENCY_UPDATES_AVAILABLE",
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
