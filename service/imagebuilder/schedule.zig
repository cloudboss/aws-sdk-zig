const AutoDisablePolicy = @import("auto_disable_policy.zig").AutoDisablePolicy;
const PipelineExecutionStartCondition = @import("pipeline_execution_start_condition.zig").PipelineExecutionStartCondition;

/// A schedule configures when and how often a pipeline will automatically
/// create a new
/// image.
pub const Schedule = struct {
    /// The policy that configures when Image Builder should automatically disable a
    /// pipeline that
    /// is failing.
    auto_disable_policy: ?AutoDisablePolicy,

    /// The start condition configures when the pipeline should trigger a new image
    /// build,
    /// as follows. If no value is set Image Builder defaults to
    /// `EXPRESSION_MATCH_AND_DEPENDENCY_UPDATES_AVAILABLE`.
    ///
    /// * `EXPRESSION_MATCH_AND_DEPENDENCY_UPDATES_AVAILABLE` (default) –
    /// When you use semantic version filters on the base image or components in
    /// your
    /// image recipe, EC2 Image Builder builds a new image only when there are new
    /// versions of
    /// the base image or components in your recipe that match the filter.
    ///
    /// For semantic version syntax, see
    /// [CreateComponent](https://docs.aws.amazon.com/imagebuilder/latest/APIReference/API_CreateComponent.html).
    ///
    /// * `EXPRESSION_MATCH_ONLY` – This condition builds a new
    /// image every time the CRON expression matches the current time.
    pipeline_execution_start_condition: ?PipelineExecutionStartCondition,

    /// The cron expression determines how often EC2 Image Builder evaluates your
    /// `pipelineExecutionStartCondition`.
    ///
    /// For information on how to format a cron expression in Image Builder, see
    /// [Use
    /// cron expressions in EC2 Image
    /// Builder](https://docs.aws.amazon.com/imagebuilder/latest/userguide/image-builder-cron.html).
    schedule_expression: ?[]const u8,

    /// The timezone that applies to the scheduling expression. For example,
    /// "Etc/UTC",
    /// "America/Los_Angeles" in the [IANA timezone
    /// format](https://www.joda.org/joda-time/timezones.html). If not specified
    /// this defaults to UTC.
    timezone: ?[]const u8,

    pub const json_field_names = .{
        .auto_disable_policy = "autoDisablePolicy",
        .pipeline_execution_start_condition = "pipelineExecutionStartCondition",
        .schedule_expression = "scheduleExpression",
        .timezone = "timezone",
    };
};
