const std = @import("std");

pub const SavingsEstimationMode = enum {
    after_discounts,
    before_discounts,

    pub const json_field_names = .{
        .after_discounts = "AfterDiscounts",
        .before_discounts = "BeforeDiscounts",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .after_discounts => "AfterDiscounts",
            .before_discounts => "BeforeDiscounts",
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
