const GameSession = @import("game_session.zig").GameSession;
const ProtectionPolicy = @import("protection_policy.zig").ProtectionPolicy;

/// A game session's properties plus the protection policy currently in force.
pub const GameSessionDetail = struct {
    /// Object that describes a game session.
    game_session: ?GameSession = null,

    /// Current status of protection for the game session.
    ///
    /// * **NoProtection** -- The game session can be
    /// terminated during a scale-down event.
    ///
    /// * **FullProtection** -- If the game session is in an
    /// `ACTIVE` status, it cannot be terminated during a scale-down
    /// event.
    protection_policy: ?ProtectionPolicy = null,

    pub const json_field_names = .{
        .game_session = "GameSession",
        .protection_policy = "ProtectionPolicy",
    };
};
