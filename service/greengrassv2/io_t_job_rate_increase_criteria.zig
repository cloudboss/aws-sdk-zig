/// Contains information about criteria to meet before a job increases its
/// rollout rate.
/// Specify either `numberOfNotifiedThings` or
/// `numberOfSucceededThings`.
pub const IoTJobRateIncreaseCriteria = struct {
    /// The number of devices to receive the job notification before the rollout
    /// rate
    /// increases.
    number_of_notified_things: ?i32 = null,

    /// The number of devices to successfully run the configuration job before the
    /// rollout rate
    /// increases.
    number_of_succeeded_things: ?i32 = null,

    pub const json_field_names = .{
        .number_of_notified_things = "numberOfNotifiedThings",
        .number_of_succeeded_things = "numberOfSucceededThings",
    };
};
