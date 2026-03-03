const std = @import("std");

pub const AdditionalOptionKeys = enum {
    cache_option,
    observations_option,
    composite_option,

    pub const json_field_names = .{
        .cache_option = "performanceTuning.caching",
        .observations_option = "observations.scope",
        .composite_option = "compositeRuleEvaluation.method",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .cache_option => "performanceTuning.caching",
            .observations_option => "observations.scope",
            .composite_option => "compositeRuleEvaluation.method",
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
