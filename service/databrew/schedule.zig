const aws = @import("aws");

/// Represents one or more dates and times when a job is to run.
pub const Schedule = struct {
    /// The ID of the Amazon Web Services account that owns the schedule.
    account_id: ?[]const u8,

    /// The date and time that the schedule was created.
    create_date: ?i64,

    /// The Amazon Resource Name (ARN) of the user who created the schedule.
    created_by: ?[]const u8,

    /// The dates and times when the job is to run. For more information, see [Cron
    /// expressions](https://docs.aws.amazon.com/databrew/latest/dg/jobs.cron.html)
    /// in the *Glue DataBrew Developer
    /// Guide*.
    cron_expression: ?[]const u8,

    /// A list of jobs to be run, according to the schedule.
    job_names: ?[]const []const u8,

    /// The Amazon Resource Name (ARN) of the user who last modified the schedule.
    last_modified_by: ?[]const u8,

    /// The date and time when the schedule was last modified.
    last_modified_date: ?i64,

    /// The name of the schedule.
    name: []const u8,

    /// The Amazon Resource Name (ARN) of the schedule.
    resource_arn: ?[]const u8,

    /// Metadata tags that have been applied to the schedule.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .create_date = "CreateDate",
        .created_by = "CreatedBy",
        .cron_expression = "CronExpression",
        .job_names = "JobNames",
        .last_modified_by = "LastModifiedBy",
        .last_modified_date = "LastModifiedDate",
        .name = "Name",
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};
