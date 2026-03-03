const TrustedAdvisorIntegrationStatus = @import("trusted_advisor_integration_status.zig").TrustedAdvisorIntegrationStatus;
const DefinitionType = @import("definition_type.zig").DefinitionType;

/// Discovery configuration associated to the workload.
pub const WorkloadDiscoveryConfig = struct {
    /// Discovery integration status in respect to Trusted Advisor for the workload.
    trusted_advisor_integration_status: ?TrustedAdvisorIntegrationStatus = null,

    /// The mode to use for identifying resources associated with the workload.
    ///
    /// You can specify `WORKLOAD_METADATA`, `APP_REGISTRY`, or both.
    workload_resource_definition: ?[]const DefinitionType = null,

    pub const json_field_names = .{
        .trusted_advisor_integration_status = "TrustedAdvisorIntegrationStatus",
        .workload_resource_definition = "WorkloadResourceDefinition",
    };
};
