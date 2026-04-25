const std = @import("std");

pub const BillingAdjustmentReasonCode = enum {
    incorrect_terms_accepted,
    incorrect_metering,
    test_environment_charges,
    alternative_procurement_channel,
    unintended_renewal,
    buyer_dissatisfaction,
    other,

    pub const json_field_names = .{
        .incorrect_terms_accepted = "INCORRECT_TERMS_ACCEPTED",
        .incorrect_metering = "INCORRECT_METERING",
        .test_environment_charges = "TEST_ENVIRONMENT_CHARGES",
        .alternative_procurement_channel = "ALTERNATIVE_PROCUREMENT_CHANNEL",
        .unintended_renewal = "UNINTENDED_RENEWAL",
        .buyer_dissatisfaction = "BUYER_DISSATISFACTION",
        .other = "OTHER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .incorrect_terms_accepted => "INCORRECT_TERMS_ACCEPTED",
            .incorrect_metering => "INCORRECT_METERING",
            .test_environment_charges => "TEST_ENVIRONMENT_CHARGES",
            .alternative_procurement_channel => "ALTERNATIVE_PROCUREMENT_CHANNEL",
            .unintended_renewal => "UNINTENDED_RENEWAL",
            .buyer_dissatisfaction => "BUYER_DISSATISFACTION",
            .other => "OTHER",
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
