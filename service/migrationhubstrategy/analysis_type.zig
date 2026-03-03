const std = @import("std");

pub const AnalysisType = enum {
    source_code_analysis,
    database_analysis,
    runtime_analysis,
    binary_analysis,

    pub const json_field_names = .{
        .source_code_analysis = "SOURCE_CODE_ANALYSIS",
        .database_analysis = "DATABASE_ANALYSIS",
        .runtime_analysis = "RUNTIME_ANALYSIS",
        .binary_analysis = "BINARY_ANALYSIS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .source_code_analysis => "SOURCE_CODE_ANALYSIS",
            .database_analysis => "DATABASE_ANALYSIS",
            .runtime_analysis => "RUNTIME_ANALYSIS",
            .binary_analysis => "BINARY_ANALYSIS",
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
