const std = @import("std");

pub const BinaryAnalyzerName = enum {
    dll_analyzer,
    bytecode_analyzer,

    pub const json_field_names = .{
        .dll_analyzer = "DLL_ANALYZER",
        .bytecode_analyzer = "BYTECODE_ANALYZER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .dll_analyzer => "DLL_ANALYZER",
            .bytecode_analyzer => "BYTECODE_ANALYZER",
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
