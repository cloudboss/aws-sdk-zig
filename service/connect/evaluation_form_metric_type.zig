const std = @import("std");

pub const EvaluationFormMetricType = enum {
    business_outcome,

    pub const json_field_names = .{
        .business_outcome = "BUSINESS_OUTCOME",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .business_outcome => "BUSINESS_OUTCOME",
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
