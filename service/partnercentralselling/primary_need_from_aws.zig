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
        .co_sell_architectural_validation = "CO_SELL_ARCHITECTURAL_VALIDATION",
        .co_sell_business_presentation = "CO_SELL_BUSINESS_PRESENTATION",
        .co_sell_competitive_information = "CO_SELL_COMPETITIVE_INFORMATION",
        .co_sell_pricing_assistance = "CO_SELL_PRICING_ASSISTANCE",
        .co_sell_technical_consultation = "CO_SELL_TECHNICAL_CONSULTATION",
        .co_sell_total_cost_of_ownership_evaluation = "CO_SELL_TOTAL_COST_OF_OWNERSHIP_EVALUATION",
        .co_sell_deal_support = "CO_SELL_DEAL_SUPPORT",
        .co_sell_support_for_public_tender_rfx = "CO_SELL_SUPPORT_FOR_PUBLIC_TENDER_RFX",
    };
};
