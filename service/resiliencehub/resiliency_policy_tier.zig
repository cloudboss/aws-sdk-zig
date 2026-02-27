pub const ResiliencyPolicyTier = enum {
    mission_critical,
    critical,
    important,
    core_services,
    non_critical,
    not_applicable,

    pub const json_field_names = .{
        .mission_critical = "MISSION_CRITICAL",
        .critical = "CRITICAL",
        .important = "IMPORTANT",
        .core_services = "CORE_SERVICES",
        .non_critical = "NON_CRITICAL",
        .not_applicable = "NOT_APPLICABLE",
    };
};
