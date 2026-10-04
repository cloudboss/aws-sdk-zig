const std = @import("std");

pub const PaymentOption = enum {
    all_upfront,
    partial_upfront,
    no_upfront,

    pub const json_field_names = .{
        .all_upfront = "AllUpfront",
        .partial_upfront = "PartialUpfront",
        .no_upfront = "NoUpfront",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .all_upfront => "AllUpfront",
            .partial_upfront => "PartialUpfront",
            .no_upfront => "NoUpfront",
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
