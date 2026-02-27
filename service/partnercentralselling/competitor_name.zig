pub const CompetitorName = enum {
    oracle_cloud,
    on_prem,
    co_location,
    akamai,
    alicloud,
    google_cloud_platform,
    ibm_softlayer,
    microsoft_azure,
    other_cost_optimization,
    no_competition,
    other,

    pub const json_field_names = .{
        .oracle_cloud = "ORACLE_CLOUD",
        .on_prem = "ON_PREM",
        .co_location = "CO_LOCATION",
        .akamai = "AKAMAI",
        .alicloud = "ALICLOUD",
        .google_cloud_platform = "GOOGLE_CLOUD_PLATFORM",
        .ibm_softlayer = "IBM_SOFTLAYER",
        .microsoft_azure = "MICROSOFT_AZURE",
        .other_cost_optimization = "OTHER_COST_OPTIMIZATION",
        .no_competition = "NO_COMPETITION",
        .other = "OTHER",
    };
};
