const std = @import("std");

pub const PriceClass = enum {
    price_class_100,
    price_class_200,
    price_class_all,
    none,

    pub const json_field_names = .{
        .price_class_100 = "PriceClass_100",
        .price_class_200 = "PriceClass_200",
        .price_class_all = "PriceClass_All",
        .none = "None",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .price_class_100 => "PriceClass_100",
            .price_class_200 => "PriceClass_200",
            .price_class_all => "PriceClass_All",
            .none => "None",
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
