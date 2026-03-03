/// Describes the meta data tags associated with a transit gateway policy rule.
pub const TransitGatewayPolicyRuleMetaData = struct {
    /// The key name for the transit gateway policy rule meta data tag.
    meta_data_key: ?[]const u8 = null,

    /// The value of the key for the transit gateway policy rule meta data tag.
    meta_data_value: ?[]const u8 = null,
};
