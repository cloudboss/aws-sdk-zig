const std = @import("std");

pub const AgreementCancellationRequestReasonCode = enum {
    incorrect_terms_accepted,
    replacing_agreement,
    test_agreement,
    alternative_procurement_channel,
    product_discontinued,
    unintended_renewal,
    buyer_dissatisfaction,
    other,

    pub const json_field_names = .{
        .incorrect_terms_accepted = "INCORRECT_TERMS_ACCEPTED",
        .replacing_agreement = "REPLACING_AGREEMENT",
        .test_agreement = "TEST_AGREEMENT",
        .alternative_procurement_channel = "ALTERNATIVE_PROCUREMENT_CHANNEL",
        .product_discontinued = "PRODUCT_DISCONTINUED",
        .unintended_renewal = "UNINTENDED_RENEWAL",
        .buyer_dissatisfaction = "BUYER_DISSATISFACTION",
        .other = "OTHER",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .incorrect_terms_accepted => "INCORRECT_TERMS_ACCEPTED",
            .replacing_agreement => "REPLACING_AGREEMENT",
            .test_agreement => "TEST_AGREEMENT",
            .alternative_procurement_channel => "ALTERNATIVE_PROCUREMENT_CHANNEL",
            .product_discontinued => "PRODUCT_DISCONTINUED",
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
