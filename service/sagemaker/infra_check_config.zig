/// Configuration information for the infrastructure health check of a training
/// job. A SageMaker-provided health check tests the health of instance hardware
/// and cluster network connectivity.
pub const InfraCheckConfig = struct {
    /// Enables an infrastructure health check.
    enable_infra_check: ?bool,

    pub const json_field_names = .{
        .enable_infra_check = "EnableInfraCheck",
    };
};
