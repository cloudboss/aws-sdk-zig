/// Information about the state of the domain relative to the latest service
/// software.
pub const AwsElasticsearchDomainServiceSoftwareOptions = struct {
    /// The epoch time when the deployment window closes for required updates. After
    /// this time,
    /// Amazon OpenSearch Service schedules the software upgrade automatically.
    automated_update_date: ?[]const u8,

    /// Whether a request to update the domain can be canceled.
    cancellable: ?bool,

    /// The version of the service software that is currently installed on the
    /// domain.
    current_version: ?[]const u8,

    /// A more detailed description of the service software status.
    description: ?[]const u8,

    /// The most recent version of the service software.
    new_version: ?[]const u8,

    /// Whether a service software update is available for the domain.
    update_available: ?bool,

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
    update_status: ?[]const u8,

    pub const json_field_names = .{
        .automated_update_date = "AutomatedUpdateDate",
        .cancellable = "Cancellable",
        .current_version = "CurrentVersion",
        .description = "Description",
        .new_version = "NewVersion",
        .update_available = "UpdateAvailable",
        .update_status = "UpdateStatus",
    };
};
