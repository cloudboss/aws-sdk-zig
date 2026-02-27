const PublicWorkforceTaskPrice = @import("public_workforce_task_price.zig").PublicWorkforceTaskPrice;

/// Describes the work to be performed by human workers.
pub const HumanLoopConfig = struct {
    /// The Amazon Resource Name (ARN) of the human task user interface.
    ///
    /// You can use standard HTML and Crowd HTML Elements to create a custom worker
    /// task template. You use this template to create a human task UI.
    ///
    /// To learn how to create a custom HTML template, see [Create Custom Worker
    /// Task
    /// Template](https://docs.aws.amazon.com/sagemaker/latest/dg/a2i-custom-templates.html).
    ///
    /// To learn how to create a human task UI, which is a worker task template that
    /// can be used in a flow definition, see [Create and Delete a Worker Task
    /// Templates](https://docs.aws.amazon.com/sagemaker/latest/dg/a2i-worker-template-console.html).
    human_task_ui_arn: []const u8,

    public_workforce_task_price: ?PublicWorkforceTaskPrice,

    /// The length of time that a task remains available for review by human
    /// workers.
    task_availability_lifetime_in_seconds: ?i32,

    /// The number of distinct workers who will perform the same task on each
    /// object. For example, if `TaskCount` is set to `3` for an image
    /// classification labeling job, three workers will classify each input image.
    /// Increasing `TaskCount` can improve label accuracy.
    task_count: i32,

    /// A description for the human worker task.
    task_description: []const u8,

    /// Keywords used to describe the task so that workers can discover the task.
    task_keywords: ?[]const []const u8,

    /// The amount of time that a worker has to complete a task. The default value
    /// is 3,600 seconds (1 hour).
    task_time_limit_in_seconds: ?i32,

    /// A title for the human worker task.
    task_title: []const u8,

    /// Amazon Resource Name (ARN) of a team of workers. To learn more about the
    /// types of workforces and work teams you can create and use with Amazon A2I,
    /// see [Create and Manage
    /// Workforces](https://docs.aws.amazon.com/sagemaker/latest/dg/sms-workforce-management.html).
    workteam_arn: []const u8,

    pub const json_field_names = .{
        .human_task_ui_arn = "HumanTaskUiArn",
        .public_workforce_task_price = "PublicWorkforceTaskPrice",
        .task_availability_lifetime_in_seconds = "TaskAvailabilityLifetimeInSeconds",
        .task_count = "TaskCount",
        .task_description = "TaskDescription",
        .task_keywords = "TaskKeywords",
        .task_time_limit_in_seconds = "TaskTimeLimitInSeconds",
        .task_title = "TaskTitle",
        .workteam_arn = "WorkteamArn",
    };
};
