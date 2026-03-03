const ClientSideActionConfig = @import("client_side_action_config.zig").ClientSideActionConfig;
const SensitivityToAct = @import("sensitivity_to_act.zig").SensitivityToAct;

/// Configures the use of the anti-DDoS managed rule group,
/// `AWSManagedRulesAntiDDoSRuleSet`. This configuration is used in
/// `ManagedRuleGroupConfig`.
///
/// The configuration that you provide here determines whether and how the rules
/// in the rule group are used.
///
/// For additional information about this and the other intelligent threat
/// mitigation rule groups,
/// see [Intelligent threat mitigation in
/// WAF](https://docs.aws.amazon.com/waf/latest/developerguide/waf-managed-protections)
/// and [Amazon Web Services Managed Rules rule groups
/// list](https://docs.aws.amazon.com/waf/latest/developerguide/aws-managed-rule-groups-list)
/// in the *WAF Developer Guide*.
pub const AWSManagedRulesAntiDDoSRuleSet = struct {
    /// Configures the request handling that's applied by the managed rule group
    /// rules `ChallengeAllDuringEvent` and `ChallengeDDoSRequests` during a
    /// distributed denial of service (DDoS) attack.
    client_side_action_config: ClientSideActionConfig,

    /// The sensitivity that the rule group rule `DDoSRequests` uses when matching
    /// against the
    /// DDoS suspicion labeling on a request. The managed rule group adds the
    /// labeling during DDoS events, before the `DDoSRequests` rule runs.
    ///
    /// The higher the sensitivity, the more levels of labeling that the rule
    /// matches:
    ///
    /// * Low sensitivity is less sensitive, causing the rule to match only on the
    ///   most likely participants in an attack, which are the requests with the
    ///   high suspicion label
    ///   `awswaf:managed:aws:anti-ddos:high-suspicion-ddos-request`.
    ///
    /// * Medium sensitivity causes the rule to match on the medium and high
    ///   suspicion labels.
    ///
    /// * High sensitivity causes the rule to match on all of the suspicion labels:
    ///   low, medium, and high.
    ///
    /// Default: `LOW`
    sensitivity_to_block: ?SensitivityToAct = null,

    pub const json_field_names = .{
        .client_side_action_config = "ClientSideActionConfig",
        .sensitivity_to_block = "SensitivityToBlock",
    };
};
