pub const HubNetworkMode = enum {
    standard,
    network_wide_exclusion,

    pub const json_field_names = .{
        .standard = "STANDARD",
        .network_wide_exclusion = "NETWORK_WIDE_EXCLUSION",
    };
};
