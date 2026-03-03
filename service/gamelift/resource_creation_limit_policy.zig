/// A policy that puts limits on the number of game sessions that a player can
/// create
/// within a specified span of time. With this policy, you can control players'
/// ability to
/// consume available resources.
///
/// The policy is evaluated when a player tries to create a new game session. On
/// receiving
/// a `CreateGameSession` request, Amazon GameLift Servers checks that the
/// player (identified by
/// `CreatorId`) has created fewer than game session limit in the specified
/// time period.
pub const ResourceCreationLimitPolicy = struct {
    /// A policy that puts limits on the number of game sessions that a player can
    /// create
    /// within a specified span of time. With this policy, you can control players'
    /// ability to
    /// consume available resources.
    ///
    /// The policy is evaluated when a player tries to create a new game session. On
    /// receiving
    /// a `CreateGameSession` request, Amazon GameLift Servers checks that the
    /// player (identified by
    /// `CreatorId`) has created fewer than game session limit in the specified
    /// time period.
    new_game_sessions_per_creator: ?i32 = null,

    /// The time span used in evaluating the resource creation limit policy.
    policy_period_in_minutes: ?i32 = null,

    pub const json_field_names = .{
        .new_game_sessions_per_creator = "NewGameSessionsPerCreator",
        .policy_period_in_minutes = "PolicyPeriodInMinutes",
    };
};
