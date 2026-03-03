const DeploymentStatus = @import("deployment_status.zig").DeploymentStatus;

/// The current options of an Elasticsearch domain service software options.
pub const ServiceSoftwareOptions = struct {
    /// Timestamp, in Epoch time, until which you can manually request a service
    /// software update. After this date, we automatically update your service
    /// software.
    automated_update_date: ?i64 = null,

    /// `True` if you are able to cancel your service software version update.
    /// `False` if you are not able to cancel your service software version.
    cancellable: ?bool = null,

    /// The current service software version that is present on the domain.
    current_version: ?[]const u8 = null,

    /// The description of the `UpdateStatus`.
    description: ?[]const u8 = null,

    /// The new service software version if one is available.
    new_version: ?[]const u8 = null,

    /// `True` if a service software is never automatically updated. `False` if a
    /// service software is automatically updated after `AutomatedUpdateDate`.
    optional_deployment: ?bool = null,

    /// `True` if you are able to update you service software version. `False` if
    /// you are not able to update your service software version.
    update_available: ?bool = null,

    /// The status of your service software update. This field can take the
    /// following values: `ELIGIBLE`, `PENDING_UPDATE`, `IN_PROGRESS`, `COMPLETED`,
    /// and `NOT_ELIGIBLE`.
    update_status: ?DeploymentStatus = null,

    pub const json_field_names = .{
        .automated_update_date = "AutomatedUpdateDate",
        .cancellable = "Cancellable",
        .current_version = "CurrentVersion",
        .description = "Description",
        .new_version = "NewVersion",
        .optional_deployment = "OptionalDeployment",
        .update_available = "UpdateAvailable",
        .update_status = "UpdateStatus",
    };
};
