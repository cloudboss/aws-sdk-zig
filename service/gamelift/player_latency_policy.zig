/// Sets a latency cap for individual players when placing a game session. With
/// a latency
/// policy in force, a game session cannot be placed in a fleet location where a
/// player
/// reports latency higher than the cap. Latency policies are used only with
/// placement
/// request that provide player latency information. Player latency policies can
/// be stacked
/// to gradually relax latency requirements over time.
pub const PlayerLatencyPolicy = struct {
    /// The maximum latency value that is allowed for any player, in milliseconds.
    /// All
    /// policies must have a value set for this property.
    maximum_individual_player_latency_milliseconds: ?i32,

    /// The length of time, in seconds, that the policy is enforced while placing a
    /// new game
    /// session. A null value for this property means that the policy is enforced
    /// until the
    /// queue times out.
    policy_duration_seconds: ?i32,

    pub const json_field_names = .{
        .maximum_individual_player_latency_milliseconds = "MaximumIndividualPlayerLatencyMilliseconds",
        .policy_duration_seconds = "PolicyDurationSeconds",
    };
};
