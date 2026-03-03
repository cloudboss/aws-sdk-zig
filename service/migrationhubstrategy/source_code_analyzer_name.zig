const std = @import("std");

pub const SourceCodeAnalyzerName = enum {
    csharp_analyzer,
    java_analyzer,
    bytecode_analyzer,
    porting_assistant,

    pub const json_field_names = .{
        .csharp_analyzer = "CSHARP_ANALYZER",
        .java_analyzer = "JAVA_ANALYZER",
        .bytecode_analyzer = "BYTECODE_ANALYZER",
        .porting_assistant = "PORTING_ASSISTANT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .csharp_analyzer => "CSHARP_ANALYZER",
            .java_analyzer => "JAVA_ANALYZER",
            .bytecode_analyzer => "BYTECODE_ANALYZER",
            .porting_assistant => "PORTING_ASSISTANT",
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
