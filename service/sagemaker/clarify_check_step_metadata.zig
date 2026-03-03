/// The container for the metadata for the ClarifyCheck step. For more
/// information, see the topic on [ClarifyCheck
/// step](https://docs.aws.amazon.com/sagemaker/latest/dg/build-and-manage-steps.html#step-type-clarify-check) in the *Amazon SageMaker Developer Guide*.
pub const ClarifyCheckStepMetadata = struct {
    /// The Amazon S3 URI of baseline constraints file to be used for the drift
    /// check.
    baseline_used_for_drift_check_constraints: ?[]const u8 = null,

    /// The Amazon S3 URI of the newly calculated baseline constraints file.
    calculated_baseline_constraints: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the check processing job that was run by
    /// this step's execution.
    check_job_arn: ?[]const u8 = null,

    /// The type of the Clarify Check step
    check_type: ?[]const u8 = null,

    /// The model package group name.
    model_package_group_name: ?[]const u8 = null,

    /// This flag indicates if a newly calculated baseline can be accessed through
    /// step properties `BaselineUsedForDriftCheckConstraints` and
    /// `BaselineUsedForDriftCheckStatistics`. If it is set to `False`, the previous
    /// baseline of the configured check type must also be available. These can be
    /// accessed through the `BaselineUsedForDriftCheckConstraints` property.
    register_new_baseline: ?bool = null,

    /// This flag indicates if the drift check against the previous baseline will be
    /// skipped or not. If it is set to `False`, the previous baseline of the
    /// configured check type must be available.
    skip_check: ?bool = null,

    /// The Amazon S3 URI of the violation report if violations are detected.
    violation_report: ?[]const u8 = null,

    pub const json_field_names = .{
        .baseline_used_for_drift_check_constraints = "BaselineUsedForDriftCheckConstraints",
        .calculated_baseline_constraints = "CalculatedBaselineConstraints",
        .check_job_arn = "CheckJobArn",
        .check_type = "CheckType",
        .model_package_group_name = "ModelPackageGroupName",
        .register_new_baseline = "RegisterNewBaseline",
        .skip_check = "SkipCheck",
        .violation_report = "ViolationReport",
    };
};
