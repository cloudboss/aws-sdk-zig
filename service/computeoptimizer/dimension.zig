const std = @import("std");

pub const Dimension = enum {
    savings_value,
    savings_value_after_discount,

    pub const json_field_names = .{
        .savings_value = "SavingsValue",
        .savings_value_after_discount = "SavingsValueAfterDiscount",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .savings_value => "SavingsValue",
            .savings_value_after_discount => "SavingsValueAfterDiscount",
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
