const MembershipJobComputePaymentConfig = @import("membership_job_compute_payment_config.zig").MembershipJobComputePaymentConfig;
const MembershipMLPaymentConfig = @import("membership_ml_payment_config.zig").MembershipMLPaymentConfig;
const MembershipQueryComputePaymentConfig = @import("membership_query_compute_payment_config.zig").MembershipQueryComputePaymentConfig;

/// An object representing the payment responsibilities accepted by the
/// collaboration member.
pub const MembershipPaymentConfiguration = struct {
    /// The payment responsibilities accepted by the collaboration member for job
    /// compute costs.
    job_compute: ?MembershipJobComputePaymentConfig = null,

    /// The payment responsibilities accepted by the collaboration member for
    /// machine learning costs.
    machine_learning: ?MembershipMLPaymentConfig = null,

    /// The payment responsibilities accepted by the collaboration member for query
    /// compute costs.
    query_compute: MembershipQueryComputePaymentConfig,

    pub const json_field_names = .{
        .job_compute = "jobCompute",
        .machine_learning = "machineLearning",
        .query_compute = "queryCompute",
    };
};
