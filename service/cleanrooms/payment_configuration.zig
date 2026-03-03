const JobComputePaymentConfig = @import("job_compute_payment_config.zig").JobComputePaymentConfig;
const MLPaymentConfig = @import("ml_payment_config.zig").MLPaymentConfig;
const QueryComputePaymentConfig = @import("query_compute_payment_config.zig").QueryComputePaymentConfig;

/// An object representing the collaboration member's payment responsibilities
/// set by the collaboration creator.
pub const PaymentConfiguration = struct {
    /// The compute configuration for the job.
    job_compute: ?JobComputePaymentConfig = null,

    /// An object representing the collaboration member's machine learning payment
    /// responsibilities set by the collaboration creator.
    machine_learning: ?MLPaymentConfig = null,

    /// The collaboration member's payment responsibilities set by the collaboration
    /// creator for query compute costs.
    query_compute: QueryComputePaymentConfig,

    pub const json_field_names = .{
        .job_compute = "jobCompute",
        .machine_learning = "machineLearning",
        .query_compute = "queryCompute",
    };
};
