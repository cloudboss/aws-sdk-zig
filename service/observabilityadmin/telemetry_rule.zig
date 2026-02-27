const TelemetryDestinationConfiguration = @import("telemetry_destination_configuration.zig").TelemetryDestinationConfiguration;
const ResourceType = @import("resource_type.zig").ResourceType;
const TelemetrySourceType = @import("telemetry_source_type.zig").TelemetrySourceType;
const TelemetryType = @import("telemetry_type.zig").TelemetryType;

/// Defines how telemetry should be configured for specific Amazon Web Services
/// resources.
pub const TelemetryRule = struct {
    /// Configuration specifying where and how the telemetry data should be
    /// delivered.
    destination_configuration: ?TelemetryDestinationConfiguration,

    /// The type of Amazon Web Services resource to configure telemetry for (e.g.,
    /// "AWS::EC2::VPC", "AWS::EKS::Cluster", "AWS::WAFv2::WebACL").
    resource_type: ?ResourceType,

    /// The organizational scope to which the rule applies, specified using accounts
    /// or organizational units.
    scope: ?[]const u8,

    /// Criteria for selecting which resources the rule applies to, such as resource
    /// tags.
    selection_criteria: ?[]const u8,

    /// The specific telemetry source types to configure for the resource, such as
    /// VPC_FLOW_LOGS or EKS_AUDIT_LOGS. TelemetrySourceTypes must be correlated
    /// with the specific resource type.
    telemetry_source_types: ?[]const TelemetrySourceType,

    /// The type of telemetry to collect (Logs, Metrics, or Traces).
    telemetry_type: TelemetryType,

    pub const json_field_names = .{
        .destination_configuration = "DestinationConfiguration",
        .resource_type = "ResourceType",
        .scope = "Scope",
        .selection_criteria = "SelectionCriteria",
        .telemetry_source_types = "TelemetrySourceTypes",
        .telemetry_type = "TelemetryType",
    };
};
