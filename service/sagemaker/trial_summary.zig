const TrialSource = @import("trial_source.zig").TrialSource;

/// A summary of the properties of a trial. To get the complete set of
/// properties, call the
/// [DescribeTrial](https://docs.aws.amazon.com/sagemaker/latest/APIReference/API_DescribeTrial.html) API and provide the `TrialName`.
pub const TrialSummary = struct {
    /// When the trial was created.
    creation_time: ?i64,

    /// The name of the trial as displayed. If `DisplayName` isn't specified,
    /// `TrialName` is displayed.
    display_name: ?[]const u8,

    /// When the trial was last modified.
    last_modified_time: ?i64,

    /// The Amazon Resource Name (ARN) of the trial.
    trial_arn: ?[]const u8,

    /// The name of the trial.
    trial_name: ?[]const u8,

    trial_source: ?TrialSource,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .display_name = "DisplayName",
        .last_modified_time = "LastModifiedTime",
        .trial_arn = "TrialArn",
        .trial_name = "TrialName",
        .trial_source = "TrialSource",
    };
};
