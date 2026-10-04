const MembershipJobComputePaymentConfig = @import("membership_job_compute_payment_config.zig").MembershipJobComputePaymentConfig;
const MembershipMLPaymentConfig = @import("membership_ml_payment_config.zig").MembershipMLPaymentConfig;
const MembershipQueryComputePaymentConfig = @import("membership_query_compute_payment_config.zig").MembershipQueryComputePaymentConfig;

/// An object representing the payment responsibilities to update for the
/// membership.
pub const UpdateMembershipPaymentConfiguration = struct {
    job_compute: ?MembershipJobComputePaymentConfig = null,

    machine_learning: ?MembershipMLPaymentConfig = null,

    query_compute: ?MembershipQueryComputePaymentConfig = null,

    pub const json_field_names = .{
        .job_compute = "jobCompute",
        .machine_learning = "machineLearning",
        .query_compute = "queryCompute",
    };
};
