const std = @import("std");

pub const ApplicationType = enum {
    before_cross_service_discounts,
    after_discounts,

    pub const json_field_names = .{
        .before_cross_service_discounts = "BEFORE_CROSS_SERVICE_DISCOUNTS",
        .after_discounts = "AFTER_DISCOUNTS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .before_cross_service_discounts => "BEFORE_CROSS_SERVICE_DISCOUNTS",
            .after_discounts => "AFTER_DISCOUNTS",
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
