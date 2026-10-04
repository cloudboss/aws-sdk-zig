const std = @import("std");

pub const BillingMode = enum {
    extendable_retention_pricing,
    fixed_retention_pricing,

    pub const json_field_names = .{
        .extendable_retention_pricing = "EXTENDABLE_RETENTION_PRICING",
        .fixed_retention_pricing = "FIXED_RETENTION_PRICING",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .extendable_retention_pricing => "EXTENDABLE_RETENTION_PRICING",
            .fixed_retention_pricing => "FIXED_RETENTION_PRICING",
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
