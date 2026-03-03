const std = @import("std");

pub const FeatureEvaluationStrategy = enum {
    all_rules,
    default_variation,

    pub const json_field_names = .{
        .all_rules = "ALL_RULES",
        .default_variation = "DEFAULT_VARIATION",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all_rules => "ALL_RULES",
            .default_variation => "DEFAULT_VARIATION",
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
