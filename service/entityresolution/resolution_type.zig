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
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
