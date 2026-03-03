/// Allows you to define a criteria to initiate the increase in rate of rollout
/// for a
/// job.
pub const RateIncreaseCriteria = struct {
    /// The threshold for number of notified things that will initiate the increase
    /// in rate
    /// of rollout.
    number_of_notified_things: ?i32 = null,

    /// The threshold for number of succeeded things that will initiate the increase
    /// in
    /// rate of rollout.
    number_of_succeeded_things: ?i32 = null,

    pub const json_field_names = .{
        .number_of_notified_things = "numberOfNotifiedThings",
        .number_of_succeeded_things = "numberOfSucceededThings",
    };
};
