/// Provides information about the state of the domain relative to the latest
/// service software.
pub const AwsOpenSearchServiceDomainServiceSoftwareOptionsDetails = struct {
    /// The epoch time when the deployment window closes for required updates. After
    /// this time, OpenSearch Service schedules the software upgrade automatically.
    automated_update_date: ?[]const u8 = null,

    /// Whether a request to update the domain can be canceled.
    cancellable: ?bool = null,

    /// The version of the service software that is currently installed on the
    /// domain.
    current_version: ?[]const u8 = null,

    /// A more detailed description of the service software status.
    description: ?[]const u8 = null,

    /// The most recent version of the service software.
    new_version: ?[]const u8 = null,

    /// Whether the service software update is optional.
    optional_deployment: ?bool = null,

    /// Whether a service software update is available for the domain.
    update_available: ?bool = null,

    /// The status of the service software update. Valid values are as follows:
    ///
    /// * `COMPLETED`
    ///
    /// * `ELIGIBLE`
    ///
    /// * `IN_PROGRESS`
    ///
    /// * `NOT_ELIGIBLE`
    ///
    /// * `PENDING_UPDATE`
    update_status: ?[]const u8 = null,

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
