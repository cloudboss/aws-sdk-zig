const std = @import("std");

pub const AnalysisType = enum {
    security,
    code_quality,

    pub const json_field_names = .{
        .security = "Security",
        .code_quality = "CodeQuality",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .security => "Security",
            .code_quality => "CodeQuality",
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
