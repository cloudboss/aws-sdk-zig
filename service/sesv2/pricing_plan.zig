const std = @import("std");

/// Identifies an Amazon SES pricing plan. See
/// `PutAccountPricingAttributesRequest$Plan` for the list of supported values
/// and
/// their meanings.
pub const PricingPlan = enum {
    none,
    essentials,
    pro,
    enterprise,

    pub const json_field_names = .{
        .none = "NONE",
        .essentials = "ESSENTIALS",
        .pro = "PRO",
        .enterprise = "ENTERPRISE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .none => "NONE",
            .essentials => "ESSENTIALS",
            .pro => "PRO",
            .enterprise => "ENTERPRISE",
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
