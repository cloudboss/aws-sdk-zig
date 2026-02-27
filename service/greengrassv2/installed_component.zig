const InstalledComponentLifecycleState = @import("installed_component_lifecycle_state.zig").InstalledComponentLifecycleState;

/// Contains information about a component on a Greengrass core device.
pub const InstalledComponent = struct {
    /// The name of the component.
    component_name: ?[]const u8,

    /// The version of the component.
    component_version: ?[]const u8,

    /// Whether or not the component is a root component.
    is_root: bool = false,

    /// The most recent deployment source that brought the component to the
    /// Greengrass core device. For
    /// a thing group deployment or thing deployment, the source will be the ID of
    /// the last deployment
    /// that contained the component. For local deployments it will be `LOCAL`.
    ///
    /// Any deployment will attempt to reinstall currently broken components on the
    /// device,
    /// which will update the last installation source.
    last_installation_source: ?[]const u8,

    /// The last time the Greengrass core device sent a message containing a
    /// component's state to the
    /// Amazon Web Services Cloud.
    ///
    /// A component does not need to see a state change for this field to update.
    last_reported_timestamp: ?i64,

    /// The status of how current the data is.
    ///
    /// This response is based off of component state changes. The status reflects
    /// component
    /// disruptions and deployments. If a component only sees a configuration update
    /// during a
    /// deployment, it might not undergo a state change and this status would not be
    /// updated.
    last_status_change_timestamp: ?i64,

    /// The lifecycle state of the component.
    lifecycle_state: ?InstalledComponentLifecycleState,

    /// A detailed response about the lifecycle state of the component that explains
    /// the reason
    /// why a component has an error or is broken.
    lifecycle_state_details: ?[]const u8,

    /// The status codes that indicate the reason for failure whenever the
    /// `lifecycleState` has an error or is in a broken state.
    ///
    /// Greengrass nucleus v2.8.0 or later is required to get an accurate
    /// `lifecycleStatusCodes` response. This response can be inaccurate in earlier
    /// Greengrass nucleus versions.
    lifecycle_status_codes: ?[]const []const u8,

    pub const json_field_names = .{
        .component_name = "componentName",
        .component_version = "componentVersion",
        .is_root = "isRoot",
        .last_installation_source = "lastInstallationSource",
        .last_reported_timestamp = "lastReportedTimestamp",
        .last_status_change_timestamp = "lastStatusChangeTimestamp",
        .lifecycle_state = "lifecycleState",
        .lifecycle_state_details = "lifecycleStateDetails",
        .lifecycle_status_codes = "lifecycleStatusCodes",
    };
};
