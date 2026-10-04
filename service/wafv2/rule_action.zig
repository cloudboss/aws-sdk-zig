const AllowAction = @import("allow_action.zig").AllowAction;
const BlockAction = @import("block_action.zig").BlockAction;
const CaptchaAction = @import("captcha_action.zig").CaptchaAction;
const ChallengeAction = @import("challenge_action.zig").ChallengeAction;
const CountAction = @import("count_action.zig").CountAction;
const MonetizeAction = @import("monetize_action.zig").MonetizeAction;

/// The action that WAF should take on a web request when it matches a rule's
/// statement. Settings at the web ACL level can override the rule action
/// setting.
pub const RuleAction = struct {
    /// Instructs WAF to allow the web request.
    allow: ?AllowAction = null,

    /// Instructs WAF to block the web request.
    block: ?BlockAction = null,

    /// Instructs WAF to run a `CAPTCHA` check against the web request.
    captcha: ?CaptchaAction = null,

    /// Instructs WAF to run a `Challenge` check against the web request.
    challenge: ?ChallengeAction = null,

    /// Instructs WAF to count the web request and then continue evaluating the
    /// request using the remaining rules in the web ACL.
    count: ?CountAction = null,

    /// Instructs WAF to return an HTTP 402 Payment Required response with a price
    /// manifest. The requesting client can complete payment and resubmit the
    /// request to gain access. This is a terminating action-requests that do not
    /// complete payment are blocked. This action is available only for web ACLs
    /// associated with Amazon CloudFront distributions and requires a
    /// `MonetizationConfig` on the web ACL.
    monetize: ?MonetizeAction = null,

    pub const json_field_names = .{
        .allow = "Allow",
        .block = "Block",
        .captcha = "Captcha",
        .challenge = "Challenge",
        .count = "Count",
        .monetize = "Monetize",
    };
};
