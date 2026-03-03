const std = @import("std");

pub const AnalysisType = enum {
    max_savings,
    custom_commitment,

    pub const json_field_names = .{
        .max_savings = "MAX_SAVINGS",
        .custom_commitment = "CUSTOM_COMMITMENT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .max_savings => "MAX_SAVINGS",
            .custom_commitment => "CUSTOM_COMMITMENT",
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
