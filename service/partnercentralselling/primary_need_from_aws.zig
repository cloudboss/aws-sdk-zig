const std = @import("std");

pub const PrimaryNeedFromAws = enum {
    co_sell_architectural_validation,
    co_sell_business_presentation,
    co_sell_competitive_information,
    co_sell_pricing_assistance,
    co_sell_technical_consultation,
    co_sell_total_cost_of_ownership_evaluation,
    co_sell_deal_support,
    co_sell_support_for_public_tender_rfx,

    pub const json_field_names = .{
        .co_sell_architectural_validation = "Co-Sell - Architectural Validation",
        .co_sell_business_presentation = "Co-Sell - Business Presentation",
        .co_sell_competitive_information = "Co-Sell - Competitive Information",
        .co_sell_pricing_assistance = "Co-Sell - Pricing Assistance",
        .co_sell_technical_consultation = "Co-Sell - Technical Consultation",
        .co_sell_total_cost_of_ownership_evaluation = "Co-Sell - Total Cost of Ownership Evaluation",
        .co_sell_deal_support = "Co-Sell - Deal Support",
        .co_sell_support_for_public_tender_rfx = "Co-Sell - Support for Public Tender / RFx",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .co_sell_architectural_validation => "Co-Sell - Architectural Validation",
            .co_sell_business_presentation => "Co-Sell - Business Presentation",
            .co_sell_competitive_information => "Co-Sell - Competitive Information",
            .co_sell_pricing_assistance => "Co-Sell - Pricing Assistance",
            .co_sell_technical_consultation => "Co-Sell - Technical Consultation",
            .co_sell_total_cost_of_ownership_evaluation => "Co-Sell - Total Cost of Ownership Evaluation",
            .co_sell_deal_support => "Co-Sell - Deal Support",
            .co_sell_support_for_public_tender_rfx => "Co-Sell - Support for Public Tender / RFx",
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
