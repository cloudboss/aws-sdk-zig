/// Specifies the monetize action settings for a rule. When WAF applies this
/// action, it returns an HTTP 402 Payment Required response containing pricing
/// information that the requesting client uses to complete payment and gain
/// access to the resource. This is a terminating action-if the client does not
/// complete the 402 payment flow, the request is blocked. This action is
/// available only for web ACLs associated with Amazon CloudFront distributions.
/// You must configure a `MonetizationConfig` on the web ACL or rule group
/// before adding rules that use this action. You cannot use the Monetize action
/// for rate-based rules.
pub const MonetizeAction = struct {
    /// An integer multiplier applied to the base price defined in the web ACL's
    /// `MonetizationConfig`. The effective price for the request is the base price
    /// multiplied by this value. Specify as a string. Valid values: 1 to 100.
    price_multiplier: ?[]const u8 = null,

    pub const json_field_names = .{
        .price_multiplier = "PriceMultiplier",
    };
};
