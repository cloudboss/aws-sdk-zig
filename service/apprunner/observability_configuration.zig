const ObservabilityConfigurationStatus = @import("observability_configuration_status.zig").ObservabilityConfigurationStatus;
const TraceConfiguration = @import("trace_configuration.zig").TraceConfiguration;

/// Describes an App Runner observability configuration resource. Multiple
/// revisions of a configuration have the same
/// `ObservabilityConfigurationName` and different
/// `ObservabilityConfigurationRevision` values.
///
/// The resource is designed to configure multiple features (currently one
/// feature, tracing). This type contains optional members that describe the
/// configuration of these features (currently one member,
/// `TraceConfiguration`). If a feature member isn't specified, the feature
/// isn't
/// enabled.
pub const ObservabilityConfiguration = struct {
    /// The time when the observability configuration was created. It's in Unix time
    /// stamp format.
    created_at: ?i64,

    /// The time when the observability configuration was deleted. It's in Unix time
    /// stamp format.
    deleted_at: ?i64,

    /// It's set to `true` for the configuration with the highest `Revision` among
    /// all configurations that share the same
    /// `ObservabilityConfigurationName`. It's set to `false` otherwise.
    latest: bool = false,

    /// The Amazon Resource Name (ARN) of this observability configuration.
    observability_configuration_arn: ?[]const u8,

    /// The customer-provided observability configuration name. It can be used in
    /// multiple revisions of a configuration.
    observability_configuration_name: ?[]const u8,

    /// The revision of this observability configuration. It's unique among all the
    /// active configurations (`"Status": "ACTIVE"`) that share the
    /// same `ObservabilityConfigurationName`.
    observability_configuration_revision: i32 = 0,

    /// The current state of the observability configuration. If the status of a
    /// configuration revision is `INACTIVE`, it was deleted and can't be
    /// used. Inactive configuration revisions are permanently removed some time
    /// after they are deleted.
    status: ?ObservabilityConfigurationStatus,

    /// The configuration of the tracing feature within this observability
    /// configuration. If not specified, tracing isn't enabled.
    trace_configuration: ?TraceConfiguration,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .deleted_at = "DeletedAt",
        .latest = "Latest",
        .observability_configuration_arn = "ObservabilityConfigurationArn",
        .observability_configuration_name = "ObservabilityConfigurationName",
        .observability_configuration_revision = "ObservabilityConfigurationRevision",
        .status = "Status",
        .trace_configuration = "TraceConfiguration",
    };
};
