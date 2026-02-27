/// Specifies the type of subscription for the HSM.
///
/// * **PRODUCTION** - The HSM is being used in a production
/// environment.
///
/// * **TRIAL** - The HSM is being used in a product
/// trial.
pub const SubscriptionType = enum {
    production,

    pub const json_field_names = .{
        .production = "PRODUCTION",
    };
};
