const TransitGatewayMeteringPayerType = @import("transit_gateway_metering_payer_type.zig").TransitGatewayMeteringPayerType;
const TransitGatewayMeteringPolicyRule = @import("transit_gateway_metering_policy_rule.zig").TransitGatewayMeteringPolicyRule;
const TransitGatewayMeteringPolicyEntryState = @import("transit_gateway_metering_policy_entry_state.zig").TransitGatewayMeteringPolicyEntryState;

/// Describes an entry in a transit gateway metering policy.
pub const TransitGatewayMeteringPolicyEntry = struct {
    /// The Amazon Web Services account ID to which the metered traffic is
    /// attributed.
    metered_account: ?TransitGatewayMeteringPayerType = null,

    /// The metering policy rule that defines traffic matching criteria.
    metering_policy_rule: ?TransitGatewayMeteringPolicyRule = null,

    /// The rule number of the metering policy entry.
    policy_rule_number: ?[]const u8 = null,

    /// The state of the metering policy entry.
    state: ?TransitGatewayMeteringPolicyEntryState = null,

    /// The date and time when the metering policy entry was last updated.
    updated_at: ?i64 = null,

    /// The date and time when the metering policy entry update becomes effective.
    update_effective_at: ?i64 = null,
};
