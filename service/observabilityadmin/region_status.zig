/// Represents the status of a multi-region operation in a specific Amazon Web
/// Services Region. This structure is used to report per-region progress for
/// both telemetry evaluation and telemetry rule replication.
pub const RegionStatus = struct {
    /// The reason for a failure status in this region. This field is only populated
    /// when `Status` indicates a failure.
    failure_reason: ?[]const u8 = null,

    /// The Amazon Web Services Region code (for example, `eu-west-1` or
    /// `us-west-2`) that this status applies to.
    region: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the telemetry rule in this spoke region.
    /// This field is only present for telemetry rule region statuses and is
    /// populated when the rule has been successfully created in the spoke region
    /// (status is `ACTIVE`).
    rule_arn: ?[]const u8 = null,

    /// The status of the operation in this region. For telemetry evaluation, valid
    /// values include `STARTING`, `RUNNING`, and `FAILED_START`. For telemetry
    /// rules, valid values include `PENDING`, `ACTIVE`, and `FAILED`.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .failure_reason = "FailureReason",
        .region = "Region",
        .rule_arn = "RuleArn",
        .status = "Status",
    };
};
