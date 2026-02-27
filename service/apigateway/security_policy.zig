pub const SecurityPolicy = enum {
    tls_1_0,
    tls_1_2,
    security_policy_tls13_1_3_2025_09,
    security_policy_tls13_1_3_fips_2025_09,
    security_policy_tls13_1_2_pfs_pq_2025_09,
    security_policy_tls13_1_2_fips_pq_2025_09,
    security_policy_tls13_1_2_pq_2025_09,
    security_policy_tls13_1_2_2021_06,
    security_policy_tls13_2025_edge,
    security_policy_tls12_pfs_2025_edge,
    security_policy_tls12_2018_edge,

    pub const json_field_names = .{
        .tls_1_0 = "TLS_1_0",
        .tls_1_2 = "TLS_1_2",
        .security_policy_tls13_1_3_2025_09 = "SecurityPolicy_TLS13_1_3_2025_09",
        .security_policy_tls13_1_3_fips_2025_09 = "SecurityPolicy_TLS13_1_3_FIPS_2025_09",
        .security_policy_tls13_1_2_pfs_pq_2025_09 = "SecurityPolicy_TLS13_1_2_PFS_PQ_2025_09",
        .security_policy_tls13_1_2_fips_pq_2025_09 = "SecurityPolicy_TLS13_1_2_FIPS_PQ_2025_09",
        .security_policy_tls13_1_2_pq_2025_09 = "SecurityPolicy_TLS13_1_2_PQ_2025_09",
        .security_policy_tls13_1_2_2021_06 = "SecurityPolicy_TLS13_1_2_2021_06",
        .security_policy_tls13_2025_edge = "SecurityPolicy_TLS13_2025_EDGE",
        .security_policy_tls12_pfs_2025_edge = "SecurityPolicy_TLS12_PFS_2025_EDGE",
        .security_policy_tls12_2018_edge = "SecurityPolicy_TLS12_2018_EDGE",
    };
};
