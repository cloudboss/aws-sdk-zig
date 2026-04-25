const TelemetryDestinationConfiguration = @import("telemetry_destination_configuration.zig").TelemetryDestinationConfiguration;
const ResourceType = @import("resource_type.zig").ResourceType;
const TelemetrySourceType = @import("telemetry_source_type.zig").TelemetrySourceType;
const TelemetryType = @import("telemetry_type.zig").TelemetryType;

/// Defines how telemetry should be configured for specific Amazon Web Services
/// resources.
pub const TelemetryRule = struct {
    /// If set to `true`, Amazon CloudWatch Observability Admin detects and
    /// remediates configuration drift in telemetry resources that it manages. For
    /// example, if a VPC flow log's format, traffic type, or aggregation interval
    /// no longer matches the rule's destination configuration, the flow log is
    /// replaced with one that matches. Only Observability Admin-managed resources
    /// are updated; customer-created resources are never modified. Currently
    /// supported for `AWS::EC2::VPC` resources (VPC flow logs).
    allow_field_updates: ?bool = null,

    /// If set to `true`, the telemetry rule is replicated to all Amazon Web
    /// Services Regions where Amazon CloudWatch Observability Admin is available in
    /// the current partition. When new regions become available, the rule
    /// automatically replicates to them. Mutually exclusive with `Regions`.
    all_regions: ?bool = null,

    /// Configuration specifying where and how the telemetry data should be
    /// delivered.
    destination_configuration: ?TelemetryDestinationConfiguration = null,

    /// An optional list of Amazon Web Services Regions where this telemetry rule
    /// should be replicated. When specified, the rule is created in the home region
    /// and automatically replicated to all listed regions. Mutually exclusive with
    /// `AllRegions`.
    regions: ?[]const []const u8 = null,

    /// The type of Amazon Web Services resource to configure telemetry for (e.g.,
    /// "AWS::EC2::VPC", "AWS::EKS::Cluster", "AWS::WAFv2::WebACL").
    resource_type: ?ResourceType = null,

    /// The organizational scope to which the rule applies, specified using accounts
    /// or organizational units.
    scope: ?[]const u8 = null,

    /// Criteria for selecting which resources the rule applies to, such as resource
    /// tags.
    selection_criteria: ?[]const u8 = null,

    /// The specific telemetry source types to configure for the resource, such as
    /// VPC_FLOW_LOGS or EKS_AUDIT_LOGS. TelemetrySourceTypes must be correlated
    /// with the specific resource type.
    telemetry_source_types: ?[]const TelemetrySourceType = null,

    /// The type of telemetry to collect (Logs, Metrics, or Traces).
    telemetry_type: TelemetryType,

    pub const json_field_names = .{
        .allow_field_updates = "AllowFieldUpdates",
        .all_regions = "AllRegions",
        .destination_configuration = "DestinationConfiguration",
        .regions = "Regions",
        .resource_type = "ResourceType",
        .scope = "Scope",
        .selection_criteria = "SelectionCriteria",
        .telemetry_source_types = "TelemetrySourceTypes",
        .telemetry_type = "TelemetryType",
    };
};
