const CanaryEntity = @import("canary_entity.zig").CanaryEntity;
const ServiceEntity = @import("service_entity.zig").ServiceEntity;
const ServiceOperationEntity = @import("service_operation_entity.zig").ServiceOperationEntity;
const ServiceLevelObjectiveEntity = @import("service_level_objective_entity.zig").ServiceLevelObjectiveEntity;

/// A union structure that contains the specific entity information for
/// different types of audit targets.
pub const AuditTargetEntity = union(enum) {
    /// Canary entity information when the audit target is a CloudWatch Synthetics
    /// canary.
    canary: ?CanaryEntity,
    /// Service entity information when the audit target is a service.
    service: ?ServiceEntity,
    /// Service operation entity information when the audit target is a specific
    /// service operation.
    service_operation: ?ServiceOperationEntity,
    /// SLO entity information when the audit target is a service level objective.
    slo: ?ServiceLevelObjectiveEntity,

    pub const json_field_names = .{
        .canary = "Canary",
        .service = "Service",
        .service_operation = "ServiceOperation",
        .slo = "Slo",
    };
};
