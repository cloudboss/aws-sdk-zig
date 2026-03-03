const TrainingMode = @import("training_mode.zig").TrainingMode;
const TrainingType = @import("training_type.zig").TrainingType;

/// Provides a summary of the properties of a solution version. For a complete
/// listing, call the
/// [DescribeSolutionVersion](https://docs.aws.amazon.com/personalize/latest/dg/API_DescribeSolutionVersion.html) API.
pub const SolutionVersionSummary = struct {
    /// The date and time (in Unix time) that this version of a solution was
    /// created.
    creation_date_time: ?i64 = null,

    /// If a solution version fails, the reason behind the failure.
    failure_reason: ?[]const u8 = null,

    /// The date and time (in Unix time) that the solution version was last updated.
    last_updated_date_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the solution version.
    solution_version_arn: ?[]const u8 = null,

    /// The status of the solution version.
    ///
    /// A solution version can be in one of the following states:
    ///
    /// * CREATE PENDING > CREATE IN_PROGRESS > ACTIVE -or- CREATE FAILED
    status: ?[]const u8 = null,

    /// The scope of training to be performed when creating the solution version. A
    /// `FULL` training considers all of the data in your dataset group.
    /// An `UPDATE` processes only the data that
    /// has changed since the latest training. Only solution versions created with
    /// the User-Personalization
    /// recipe can use `UPDATE`.
    training_mode: ?TrainingMode = null,

    /// Whether the solution version was created automatically or manually.
    training_type: ?TrainingType = null,

    pub const json_field_names = .{
        .creation_date_time = "creationDateTime",
        .failure_reason = "failureReason",
        .last_updated_date_time = "lastUpdatedDateTime",
        .solution_version_arn = "solutionVersionArn",
        .status = "status",
        .training_mode = "trainingMode",
        .training_type = "trainingType",
    };
};
