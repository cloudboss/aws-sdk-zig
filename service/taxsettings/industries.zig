pub const Industries = enum {
    circulating_org,
    professional_org,
    banks,
    insurance,
    pension_and_benefit_funds,
    development_agencies,

    pub const json_field_names = .{
        .circulating_org = "CIRCULATING_ORG",
        .professional_org = "PROFESSIONAL_ORG",
        .banks = "BANKS",
        .insurance = "INSURANCE",
        .pension_and_benefit_funds = "PENSION_AND_BENEFIT_FUNDS",
        .development_agencies = "DEVELOPMENT_AGENCIES",
    };
};
