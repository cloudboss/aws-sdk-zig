pub const IndicatorType = enum {
    ttp_observed,
    impossible_travel,
    flagged_ip_address,
    new_geolocation,
    new_aso,
    new_user_agent,
    related_finding,
    related_finding_group,

    pub const json_field_names = .{
        .ttp_observed = "TTP_OBSERVED",
        .impossible_travel = "IMPOSSIBLE_TRAVEL",
        .flagged_ip_address = "FLAGGED_IP_ADDRESS",
        .new_geolocation = "NEW_GEOLOCATION",
        .new_aso = "NEW_ASO",
        .new_user_agent = "NEW_USER_AGENT",
        .related_finding = "RELATED_FINDING",
        .related_finding_group = "RELATED_FINDING_GROUP",
    };
};
