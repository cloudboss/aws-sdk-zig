const aws = @import("aws");

const DisruptionCompliance = @import("disruption_compliance.zig").DisruptionCompliance;
const DifferenceType = @import("difference_type.zig").DifferenceType;
const DriftType = @import("drift_type.zig").DriftType;

/// Indicates the compliance drifts (recovery time objective (RTO) and recovery
/// point
/// objective (RPO)) that were detected for an assessed entity.
pub const ComplianceDrift = struct {
    /// Assessment identifier that is associated with this drift item.
    actual_reference_id: ?[]const u8,

    /// Actual compliance value of the entity.
    actual_value: ?[]const aws.map.MapEntry(DisruptionCompliance),

    /// Identifier of your application.
    app_id: ?[]const u8,

    /// Published version of your application on which drift was detected.
    app_version: ?[]const u8,

    /// Difference type between actual and expected recovery point objective (RPO)
    /// and recovery
    /// time objective (RTO) values. Currently, Resilience Hub supports only
    /// `NotEqual` difference type.
    diff_type: ?DifferenceType,

    /// The type of drift detected. Currently, Resilience Hub supports only
    /// **ApplicationCompliance** drift type.
    drift_type: ?DriftType,

    /// Identifier of an entity in which drift was detected. For compliance drift,
    /// the entity ID
    /// can be either application ID or the AppComponent ID.
    entity_id: ?[]const u8,

    /// The type of entity in which drift was detected. For compliance drifts,
    /// Resilience Hub supports `AWS::ResilienceHub::AppComponent` and
    /// `AWS::ResilienceHub::Application`.
    entity_type: ?[]const u8,

    /// Assessment identifier of a previous assessment of the same application
    /// version. Resilience Hub uses the previous assessment (associated with the
    /// reference identifier) to
    /// compare the compliance with the current assessment to identify drifts.
    expected_reference_id: ?[]const u8,

    /// The expected compliance value of an entity.
    expected_value: ?[]const aws.map.MapEntry(DisruptionCompliance),

    pub const json_field_names = .{
        .actual_reference_id = "actualReferenceId",
        .actual_value = "actualValue",
        .app_id = "appId",
        .app_version = "appVersion",
        .diff_type = "diffType",
        .drift_type = "driftType",
        .entity_id = "entityId",
        .entity_type = "entityType",
        .expected_reference_id = "expectedReferenceId",
        .expected_value = "expectedValue",
    };
};
