/// The quotas that apply to web functions in your account in the current AWS
/// Region.
pub const AccountQuotas = struct {
    /// The maximum number of endpoints that a single web function can have.
    max_endpoints_per_function: i32,

    /// The maximum number of revisions that a single web function can have.
    max_revisions_per_function: i32,

    /// The maximum total number of Arm vCPUs that you can allocate across all of
    /// your web functions in the current AWS Region.
    max_total_arm_v_cpus: i32,

    /// The maximum number of requests per second allowed across all of your web
    /// function endpoints in your account in the current AWS Region.
    max_total_rate_limit: i32,

    pub const json_field_names = .{
        .max_endpoints_per_function = "maxEndpointsPerFunction",
        .max_revisions_per_function = "maxRevisionsPerFunction",
        .max_total_arm_v_cpus = "maxTotalArmVCpus",
        .max_total_rate_limit = "maxTotalRateLimit",
    };
};
