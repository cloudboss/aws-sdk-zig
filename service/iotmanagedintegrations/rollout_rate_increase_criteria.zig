/// Structure representing rollout config criteria.
pub const RolloutRateIncreaseCriteria = struct {
    /// The threshold for number of notified things that will initiate the increase
    /// in rate of rollout.
    number_of_notified_things: ?i32,

    /// The threshold for number of succeeded things that will initiate the increase
    /// in rate of rollout.
    number_of_succeeded_things: ?i32,

    pub const json_field_names = .{
        .number_of_notified_things = "numberOfNotifiedThings",
        .number_of_succeeded_things = "numberOfSucceededThings",
    };
};
