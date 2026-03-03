/// Container for the metadata for a Quality check step. For more information,
/// see the topic on [QualityCheck
/// step](https://docs.aws.amazon.com/sagemaker/latest/dg/build-and-manage-steps.html#step-type-quality-check) in the *Amazon SageMaker Developer Guide*.
pub const QualityCheckStepMetadata = struct {
    /// The Amazon S3 URI of the baseline constraints file used for the drift check.
    baseline_used_for_drift_check_constraints: ?[]const u8 = null,

    /// The Amazon S3 URI of the baseline statistics file used for the drift check.
    baseline_used_for_drift_check_statistics: ?[]const u8 = null,

    /// The Amazon S3 URI of the newly calculated baseline constraints file.
    calculated_baseline_constraints: ?[]const u8 = null,

    /// The Amazon S3 URI of the newly calculated baseline statistics file.
    calculated_baseline_statistics: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Quality check processing job that was
    /// run by this step execution.
    check_job_arn: ?[]const u8 = null,

    /// The type of the Quality check step.
    check_type: ?[]const u8 = null,

    /// The model package group name.
    model_package_group_name: ?[]const u8 = null,

    /// This flag indicates if a newly calculated baseline can be accessed through
    /// step properties `BaselineUsedForDriftCheckConstraints` and
    /// `BaselineUsedForDriftCheckStatistics`. If it is set to `False`, the previous
    /// baseline of the configured check type must also be available. These can be
    /// accessed through the `BaselineUsedForDriftCheckConstraints` and `
    /// BaselineUsedForDriftCheckStatistics` properties.
    register_new_baseline: ?bool = null,

    /// This flag indicates if the drift check against the previous baseline will be
    /// skipped or not. If it is set to `False`, the previous baseline of the
    /// configured check type must be available.
    skip_check: ?bool = null,

    /// The Amazon S3 URI of violation report if violations are detected.
    violation_report: ?[]const u8 = null,

    pub const json_field_names = .{
        .baseline_used_for_drift_check_constraints = "BaselineUsedForDriftCheckConstraints",
        .baseline_used_for_drift_check_statistics = "BaselineUsedForDriftCheckStatistics",
        .calculated_baseline_constraints = "CalculatedBaselineConstraints",
        .calculated_baseline_statistics = "CalculatedBaselineStatistics",
        .check_job_arn = "CheckJobArn",
        .check_type = "CheckType",
        .model_package_group_name = "ModelPackageGroupName",
        .register_new_baseline = "RegisterNewBaseline",
        .skip_check = "SkipCheck",
        .violation_report = "ViolationReport",
    };
};
