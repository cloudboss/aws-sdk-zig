const ClientSideAction = @import("client_side_action.zig").ClientSideAction;

/// This is part of the configuration for the managed rules
/// `AWSManagedRulesAntiDDoSRuleSet`
/// in `ManagedRuleGroupConfig`.
pub const ClientSideActionConfig = struct {
    /// Configuration for the use of the `AWSManagedRulesAntiDDoSRuleSet` rules
    /// `ChallengeAllDuringEvent` and `ChallengeDDoSRequests`.
    ///
    /// This setting isn't related to the configuration of the `Challenge` action
    /// itself. It only
    /// configures the use of the two anti-DDoS rules named here.
    ///
    /// You can enable or disable the use of these rules, and you can configure how
    /// to use them when they are enabled.
    challenge: ClientSideAction,

    pub const json_field_names = .{
        .challenge = "Challenge",
    };
};
