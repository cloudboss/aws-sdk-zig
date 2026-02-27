/// The schedule of when Amazon Redshift Serverless should run the scheduled
/// action.
pub const Schedule = union(enum) {
    /// The timestamp of when Amazon Redshift Serverless should run the scheduled
    /// action. Timestamp is in UTC. Format of at expression is
    /// `yyyy-mm-ddThh:mm:ss`. For example, `2016-03-04T17:27:00`.
    at: ?i64,
    /// The cron expression to use to schedule a recurring scheduled action.
    /// Schedule invocations must be separated by at least one hour. Times are in
    /// UTC.
    ///
    /// Format of cron expressions is `(Minutes Hours Day-of-month Month Day-of-week
    /// Year)`. For example, `"(0 10 ? * MON *)"`. For more information, see [Cron
    /// Expressions](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html#CronExpressions) in the *Amazon CloudWatch Events User Guide*.
    cron: ?[]const u8,

    pub const json_field_names = .{
        .at = "at",
        .cron = "cron",
    };
};
