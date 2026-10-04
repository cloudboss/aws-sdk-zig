/// A metadata key-value pair for a transit gateway policy rule.
pub const TransitGatewayRequestPolicyRuleMetaData = struct {
    /// The key of the metadata pair for the policy rule.
    meta_data_key: ?[]const u8 = null,

    /// The value of the metadata pair for the policy rule.
    meta_data_value: ?[]const u8 = null,
};
