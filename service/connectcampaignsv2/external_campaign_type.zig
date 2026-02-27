/// The type of campaign externally exposed in APIs.
pub const ExternalCampaignType = enum {
    managed,
    journey,

    pub const json_field_names = .{
        .managed = "MANAGED",
        .journey = "JOURNEY",
    };
};
