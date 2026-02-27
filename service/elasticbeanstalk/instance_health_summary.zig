/// Represents summary information about the health of an instance. For more
/// information,
/// see [Health Colors and
/// Statuses](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/health-enhanced-status.html).
pub const InstanceHealthSummary = struct {
    /// **Red.** The health agent is reporting a high number of request
    /// failures or other issues for an instance or environment.
    degraded: ?i32,

    /// **Green.** An operation is in progress on an instance.
    info: ?i32,

    /// **Grey.** AWS Elastic Beanstalk and the health agent are
    /// reporting no data on an instance.
    no_data: ?i32,

    /// **Green.** An instance is passing health checks and the health
    /// agent is not reporting any problems.
    ok: ?i32,

    /// **Grey.** An operation is in progress on an instance within the
    /// command timeout.
    pending: ?i32,

    /// **Red.** The health agent is reporting a very high number of
    /// request failures or other issues for an instance or environment.
    severe: ?i32,

    /// **Grey.** AWS Elastic Beanstalk and the health agent are
    /// reporting an insufficient amount of data on an instance.
    unknown: ?i32,

    /// **Yellow.** The health agent is reporting a moderate number of
    /// request failures or other issues for an instance or environment.
    warning: ?i32,
};
