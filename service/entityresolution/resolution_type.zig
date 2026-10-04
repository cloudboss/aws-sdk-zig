const std = @import("std");

pub const ResolutionType = enum {
    rule_matching,
    ml_matching,
    provider,

    pub const json_field_names = .{
        .rule_matching = "RULE_MATCHING",
        .ml_matching = "ML_MATCHING",
        .provider = "PROVIDER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .rule_matching => "RULE_MATCHING",
            .ml_matching => "ML_MATCHING",
            .provider => "PROVIDER",
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
