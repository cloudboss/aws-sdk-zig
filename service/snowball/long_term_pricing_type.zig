const std = @import("std");

pub const LongTermPricingType = enum {
    one_year,
    three_year,
    one_month,

    pub const json_field_names = .{
        .one_year = "OneYear",
        .three_year = "ThreeYear",
        .one_month = "OneMonth",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .one_year => "OneYear",
            .three_year => "ThreeYear",
            .one_month => "OneMonth",
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
