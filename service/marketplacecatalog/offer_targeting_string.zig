pub const OfferTargetingString = enum {
    buyer_accounts,
    participating_programs,
    country_codes,
    none,

    pub const json_field_names = .{
        .buyer_accounts = "BuyerAccounts",
        .participating_programs = "ParticipatingPrograms",
        .country_codes = "CountryCodes",
        .none = "None",
    };
};
