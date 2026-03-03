const aws = @import("aws");

const NotificationProperty = @import("notification_property.zig").NotificationProperty;

/// Defines an action to be initiated by a trigger.
pub const Action = struct {
    /// The job arguments used when this trigger fires. For this job run, they
    /// replace the default arguments set in the job definition itself.
    ///
    /// You can specify arguments here that your own job-execution script
    /// consumes, as well as arguments that Glue itself consumes.
    ///
    /// For information about how to specify and consume your own Job arguments, see
    /// the [Calling Glue APIs in
    /// Python](https://docs.aws.amazon.com/glue/latest/dg/aws-glue-programming-python-calling.html) topic in the developer guide.
    ///
    /// For information about the key-value pairs that Glue consumes to set up your
    /// job, see the [Special Parameters Used by
    /// Glue](https://docs.aws.amazon.com/glue/latest/dg/aws-glue-programming-etl-glue-arguments.html) topic in the developer guide.
    arguments: ?[]const aws.map.StringMapEntry = null,

    /// The name of the crawler to be used with this action.
    crawler_name: ?[]const u8 = null,

    /// The name of a job to be run.
    job_name: ?[]const u8 = null,

    /// Specifies configuration properties of a job run notification.
    notification_property: ?NotificationProperty = null,

    /// The name of the `SecurityConfiguration` structure to be used with this
    /// action.
    security_configuration: ?[]const u8 = null,

    /// The `JobRun` timeout in minutes. This is the maximum time that a job run can
    /// consume resources before it is terminated and enters `TIMEOUT` status. This
    /// overrides the timeout value set in the parent job.
    ///
    /// Jobs must have timeout values less than 7 days or 10080 minutes. Otherwise,
    /// the jobs will throw an exception.
    ///
    /// When the value is left blank, the timeout is defaulted to 2880 minutes.
    ///
    /// Any existing Glue jobs that had a timeout value greater than 7 days will be
    /// defaulted to 7 days. For instance if you have specified a timeout of 20 days
    /// for a batch job, it will be stopped on the 7th day.
    ///
    /// For streaming jobs, if you have set up a maintenance window, it will be
    /// restarted during the maintenance window after 7 days.
    timeout: ?i32 = null,

    pub const json_field_names = .{
        .arguments = "Arguments",
        .crawler_name = "CrawlerName",
        .job_name = "JobName",
        .notification_property = "NotificationProperty",
        .security_configuration = "SecurityConfiguration",
        .timeout = "Timeout",
    };
};
