const DataDestination = @import("data_destination.zig").DataDestination;

/// Provides a summary of the Explainability export properties used in the
/// ListExplainabilityExports operation. To get a complete set of
/// properties, call the DescribeExplainabilityExport operation, and
/// provide the `ExplainabilityExportArn`.
pub const ExplainabilityExportSummary = struct {
    /// When the Explainability was created.
    creation_time: ?i64 = null,

    destination: ?DataDestination = null,

    /// The Amazon Resource Name (ARN) of the Explainability export.
    explainability_export_arn: ?[]const u8 = null,

    /// The name of the Explainability export
    explainability_export_name: ?[]const u8 = null,

    /// The last time the resource was modified. The timestamp depends on the status
    /// of the
    /// job:
    ///
    /// * `CREATE_PENDING` - The `CreationTime`.
    ///
    /// * `CREATE_IN_PROGRESS` - The current timestamp.
    ///
    /// * `CREATE_STOPPING` - The current timestamp.
    ///
    /// * `CREATE_STOPPED` - When the job stopped.
    ///
    /// * `ACTIVE` or `CREATE_FAILED` - When the job finished or
    /// failed.
    last_modification_time: ?i64 = null,

    /// Information about any errors that may have occurred during the
    /// Explainability
    /// export.
    message: ?[]const u8 = null,

    /// The status of the Explainability export. States include:
    ///
    /// * `ACTIVE`
    ///
    /// * `CREATE_PENDING`, `CREATE_IN_PROGRESS`,
    /// `CREATE_FAILED`
    ///
    /// * `CREATE_STOPPING`, `CREATE_STOPPED`
    ///
    /// * `DELETE_PENDING`, `DELETE_IN_PROGRESS`,
    /// `DELETE_FAILED`
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .destination = "Destination",
        .explainability_export_arn = "ExplainabilityExportArn",
        .explainability_export_name = "ExplainabilityExportName",
        .last_modification_time = "LastModificationTime",
        .message = "Message",
        .status = "Status",
    };
};
