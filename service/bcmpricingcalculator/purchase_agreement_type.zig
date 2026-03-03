const std = @import("std");

pub const PurchaseAgreementType = enum {
    savings_plans,
    reserved_instance,

    pub const json_field_names = .{
        .savings_plans = "SAVINGS_PLANS",
        .reserved_instance = "RESERVED_INSTANCE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .savings_plans => "SAVINGS_PLANS",
            .reserved_instance => "RESERVED_INSTANCE",
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
