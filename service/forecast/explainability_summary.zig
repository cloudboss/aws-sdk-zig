const ExplainabilityConfig = @import("explainability_config.zig").ExplainabilityConfig;

/// Provides a summary of the Explainability properties used in the
/// ListExplainabilities operation. To get a complete set of properties,
/// call the DescribeExplainability operation, and provide the listed
/// `ExplainabilityArn`.
pub const ExplainabilitySummary = struct {
    /// When the Explainability was created.
    creation_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the Explainability.
    explainability_arn: ?[]const u8 = null,

    /// The configuration settings that define the granularity of time series and
    /// time points
    /// for the Explainability.
    explainability_config: ?ExplainabilityConfig = null,

    /// The name of the Explainability.
    explainability_name: ?[]const u8 = null,

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
    /// Explainability creation
    /// process.
    message: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Predictor or Forecast used to create
    /// the
    /// Explainability.
    resource_arn: ?[]const u8 = null,

    /// The status of the Explainability. States include:
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
        .explainability_arn = "ExplainabilityArn",
        .explainability_config = "ExplainabilityConfig",
        .explainability_name = "ExplainabilityName",
        .last_modification_time = "LastModificationTime",
        .message = "Message",
        .resource_arn = "ResourceArn",
        .status = "Status",
    };
};
