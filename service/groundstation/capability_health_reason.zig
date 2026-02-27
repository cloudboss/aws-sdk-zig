pub const CapabilityHealthReason = enum {
    no_registered_agent,
    invalid_ip_ownership,
    not_authorized_to_create_slr,
    unverified_ip_ownership,
    initializing_dataplane,
    dataplane_failure,
    healthy,

    pub const json_field_names = .{
        .no_registered_agent = "NO_REGISTERED_AGENT",
        .invalid_ip_ownership = "INVALID_IP_OWNERSHIP",
        .not_authorized_to_create_slr = "NOT_AUTHORIZED_TO_CREATE_SLR",
        .unverified_ip_ownership = "UNVERIFIED_IP_OWNERSHIP",
        .initializing_dataplane = "INITIALIZING_DATAPLANE",
        .dataplane_failure = "DATAPLANE_FAILURE",
        .healthy = "HEALTHY",
    };
};
