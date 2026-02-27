/// Describes information used for one or more scheduled scaling action updates
/// in a
/// [BatchPutScheduledUpdateGroupAction](https://docs.aws.amazon.com/autoscaling/ec2/APIReference/API_BatchPutScheduledUpdateGroupAction.html)
/// operation.
pub const ScheduledUpdateGroupActionRequest = struct {
    /// The desired capacity is the initial capacity of the Auto Scaling group after
    /// the scheduled
    /// action runs and the capacity it attempts to maintain.
    desired_capacity: ?i32,

    /// The date and time for the recurring schedule to end, in UTC.
    end_time: ?i64,

    /// The maximum size of the Auto Scaling group.
    max_size: ?i32,

    /// The minimum size of the Auto Scaling group.
    min_size: ?i32,

    /// The recurring schedule for the action, in Unix cron syntax format. This
    /// format
    /// consists of five fields separated by white spaces: [Minute] [Hour]
    /// [Day_of_Month]
    /// [Month_of_Year] [Day_of_Week]. The value must be in quotes (for example,
    /// `"30 0 1
    /// 1,6,12 *"`). For more information about this format, see
    /// [Crontab](http://crontab.org).
    ///
    /// When `StartTime` and `EndTime` are specified with
    /// `Recurrence`, they form the boundaries of when the recurring action
    /// starts and stops.
    ///
    /// Cron expressions use Universal Coordinated Time (UTC) by default.
    recurrence: ?[]const u8,

    /// The name of the scaling action.
    scheduled_action_name: []const u8,

    /// The date and time for the action to start, in YYYY-MM-DDThh:mm:ssZ format in
    /// UTC/GMT
    /// only and in quotes (for example, `"2019-06-01T00:00:00Z"`).
    ///
    /// If you specify `Recurrence` and `StartTime`, Amazon EC2 Auto Scaling
    /// performs
    /// the action at this time, and then performs the action based on the specified
    /// recurrence.
    ///
    /// If you try to schedule the action in the past, Amazon EC2 Auto Scaling
    /// returns an error
    /// message.
    start_time: ?i64,

    /// Specifies the time zone for a cron expression. If a time zone is not
    /// provided, UTC is
    /// used by default.
    ///
    /// Valid values are the canonical names of the IANA time zones, derived from
    /// the IANA
    /// Time Zone Database (such as `Etc/GMT+9` or `Pacific/Tahiti`). For
    /// more information, see
    /// [https://en.wikipedia.org/wiki/List_of_tz_database_time_zones](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones).
    time_zone: ?[]const u8,
};
