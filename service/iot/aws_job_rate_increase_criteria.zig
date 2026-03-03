/// The criteria to initiate the increase in rate of rollout for a job.
pub const AwsJobRateIncreaseCriteria = struct {
    /// When this number of things have been notified, it will initiate an increase
    /// in the rollout
    /// rate.
    number_of_notified_things: ?i32 = null,

    /// When this number of things have succeeded in their job execution, it will
    /// initiate an
    /// increase in the rollout rate.
    number_of_succeeded_things: ?i32 = null,

    pub const json_field_names = .{
        .number_of_notified_things = "numberOfNotifiedThings",
        .number_of_succeeded_things = "numberOfSucceededThings",
    };
};
