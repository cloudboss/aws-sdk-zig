const std = @import("std");

pub const BillingFeature = enum {
    ri_sharing,
    ri_sharing_history,
    credit_sharing,
    credit_sharing_history,
    credit_level_sharing,
    billing_alerts,
    credit_preference_options,

    pub const json_field_names = .{
        .ri_sharing = "RI_SHARING",
        .ri_sharing_history = "RI_SHARING_HISTORY",
        .credit_sharing = "CREDIT_SHARING",
        .credit_sharing_history = "CREDIT_SHARING_HISTORY",
        .credit_level_sharing = "CREDIT_LEVEL_SHARING",
        .billing_alerts = "BILLING_ALERTS",
        .credit_preference_options = "CREDIT_PREFERENCE_OPTIONS",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .ri_sharing => "RI_SHARING",
            .ri_sharing_history => "RI_SHARING_HISTORY",
            .credit_sharing => "CREDIT_SHARING",
            .credit_sharing_history => "CREDIT_SHARING_HISTORY",
            .credit_level_sharing => "CREDIT_LEVEL_SHARING",
            .billing_alerts => "BILLING_ALERTS",
            .credit_preference_options => "CREDIT_PREFERENCE_OPTIONS",
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
