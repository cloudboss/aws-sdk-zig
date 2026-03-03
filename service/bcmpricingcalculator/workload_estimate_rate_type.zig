const std = @import("std");

pub const WorkloadEstimateRateType = enum {
    before_discounts,
    after_discounts,
    after_discounts_and_commitments,

    pub const json_field_names = .{
        .before_discounts = "BEFORE_DISCOUNTS",
        .after_discounts = "AFTER_DISCOUNTS",
        .after_discounts_and_commitments = "AFTER_DISCOUNTS_AND_COMMITMENTS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .before_discounts => "BEFORE_DISCOUNTS",
            .after_discounts => "AFTER_DISCOUNTS",
            .after_discounts_and_commitments => "AFTER_DISCOUNTS_AND_COMMITMENTS",
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
