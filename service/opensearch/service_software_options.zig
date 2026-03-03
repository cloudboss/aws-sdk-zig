const DeploymentStatus = @import("deployment_status.zig").DeploymentStatus;

/// The current status of the service software for an Amazon OpenSearch Service
/// domain.
/// For more information, see [Service
/// software updates in Amazon OpenSearch
/// Service](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/service-software.html).
pub const ServiceSoftwareOptions = struct {
    /// The timestamp, in Epoch time, until which you can manually request a service
    /// software
    /// update. After this date, we automatically update your service software.
    automated_update_date: ?i64 = null,

    /// True if you're able to cancel your service software version update. False if
    /// you
    /// can't cancel your service software update.
    cancellable: ?bool = null,

    /// The current service software version present on the domain.
    current_version: ?[]const u8 = null,

    /// A description of the service software update status.
    description: ?[]const u8 = null,

    /// The new service software version, if one is available.
    new_version: ?[]const u8 = null,

    /// True if a service software is never automatically updated. False if a
    /// service software
    /// is automatically updated after the automated update date.
    optional_deployment: ?bool = null,

    /// True if you're able to update your service software version. False if you
    /// can't update
    /// your service software version.
    update_available: ?bool = null,

    /// The status of your service software update.
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
