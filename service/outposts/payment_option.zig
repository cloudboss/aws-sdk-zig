const std = @import("std");

pub const PaymentOption = enum {
    all_upfront,
    no_upfront,
    partial_upfront,

    pub const json_field_names = .{
        .all_upfront = "ALL_UPFRONT",
        .no_upfront = "NO_UPFRONT",
        .partial_upfront = "PARTIAL_UPFRONT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all_upfront => "ALL_UPFRONT",
            .no_upfront => "NO_UPFRONT",
            .partial_upfront => "PARTIAL_UPFRONT",
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
