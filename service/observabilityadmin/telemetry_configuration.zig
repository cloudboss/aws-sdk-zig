const aws = @import("aws");

const ResourceType = @import("resource_type.zig").ResourceType;
const TelemetryState = @import("telemetry_state.zig").TelemetryState;
const TelemetrySourceType = @import("telemetry_source_type.zig").TelemetrySourceType;

/// A model representing the state of a resource within an account according to
/// telemetry config.
pub const TelemetryConfiguration = struct {
    /// The account ID which contains the resource managed in telemetry
    /// configuration. An example of a valid account ID is `012345678901`.
    account_identifier: ?[]const u8 = null,

    /// The timestamp of the last change to the telemetry configuration for the
    /// resource. For example, `1728679196318`.
    last_update_time_stamp: ?i64 = null,

    /// The identifier of the resource, for example for Amazon VPC, it would be
    /// `vpc-1a2b3c4d5e6f1a2b3`.
    resource_identifier: ?[]const u8 = null,

    /// Tags associated with the resource, for example `{ Name: "ExampleInstance",
    /// Environment: "Development" }`.
    resource_tags: ?[]const aws.map.StringMapEntry = null,

    /// The type of resource, for example `Amazon Web Services::EC2::Instance`, or
    /// `Amazon Web Services::EKS::Cluster`, etc.
    resource_type: ?ResourceType = null,

    /// The configuration state for the resource, for example `{ Logs:
    /// NotApplicable; Metrics: Enabled; Traces: NotApplicable; }`.
    telemetry_configuration_state: ?[]const aws.map.MapEntry(TelemetryState) = null,

    telemetry_source_type: ?TelemetrySourceType = null,

    pub const json_field_names = .{
        .account_identifier = "AccountIdentifier",
        .last_update_time_stamp = "LastUpdateTimeStamp",
        .resource_identifier = "ResourceIdentifier",
        .resource_tags = "ResourceTags",
        .resource_type = "ResourceType",
        .telemetry_configuration_state = "TelemetryConfigurationState",
        .telemetry_source_type = "TelemetrySourceType",
    };
};
