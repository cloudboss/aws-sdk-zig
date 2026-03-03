const JobFilterName = @import("job_filter_name.zig").JobFilterName;

/// Describes a filter that returns a more specific list of recommendation
/// export jobs.
/// Use this filter with the DescribeRecommendationExportJobs
/// action.
///
/// You can use `EBSFilter` with the GetEBSVolumeRecommendations action,
/// `LambdaFunctionRecommendationFilter` with the
/// GetLambdaFunctionRecommendations action, and `Filter` with
/// the GetAutoScalingGroupRecommendations and GetEC2InstanceRecommendations
/// actions.
pub const JobFilter = struct {
    /// The name of the filter.
    ///
    /// Specify `ResourceType` to return export jobs of a specific resource type
    /// (for example, `Ec2Instance`).
    ///
    /// Specify `JobStatus` to return export jobs with a specific status (e.g,
    /// `Complete`).
    name: ?JobFilterName = null,

    /// The value of the filter.
    ///
    /// The valid values for this parameter are as follows, depending on what you
    /// specify for
    /// the `name` parameter:
    ///
    /// * Specify `Ec2Instance` or `AutoScalingGroup` if you
    /// specify the `name` parameter as `ResourceType`. There is
    /// no filter for EBS volumes because volume recommendations cannot be exported
    /// at
    /// this time.
    ///
    /// * Specify `Queued`, `InProgress`, `Complete`,
    /// or `Failed` if you specify the `name` parameter as
    /// `JobStatus`.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .values = "values",
    };
};
