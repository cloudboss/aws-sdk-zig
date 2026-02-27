pub const TLSSecurityPolicy = enum {
    policy_min_tls_1_0_2019_07,
    policy_min_tls_1_2_2019_07,
    policy_min_tls_1_2_pfs_2023_10,

    pub const json_field_names = .{
        .policy_min_tls_1_0_2019_07 = "POLICY_MIN_TLS_1_0_2019_07",
        .policy_min_tls_1_2_2019_07 = "POLICY_MIN_TLS_1_2_2019_07",
        .policy_min_tls_1_2_pfs_2023_10 = "POLICY_MIN_TLS_1_2_PFS_2023_10",
    };
};
