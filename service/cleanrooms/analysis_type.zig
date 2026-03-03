const std = @import("std");

pub const AnalysisType = enum {
    direct_analysis,
    additional_analysis,

    pub const json_field_names = .{
        .direct_analysis = "DIRECT_ANALYSIS",
        .additional_analysis = "ADDITIONAL_ANALYSIS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .direct_analysis => "DIRECT_ANALYSIS",
            .additional_analysis => "ADDITIONAL_ANALYSIS",
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
