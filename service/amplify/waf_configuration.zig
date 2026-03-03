const WafStatus = @import("waf_status.zig").WafStatus;

/// Describes the Firewall configuration for a hosted Amplify application.
/// Firewall support enables you to protect your web applications with a direct
/// integration
/// with WAF. For more information about using WAF protections
/// for an Amplify application, see [Firewall support for hosted
/// sites](https://docs.aws.amazon.com/amplify/latest/userguide/WAF-integration.html) in the *Amplify User Guide*.
pub const WafConfiguration = struct {
    /// The reason for the current status of the Firewall configuration.
    status_reason: ?[]const u8 = null,

    /// The status of the process to associate or disassociate a web ACL to an
    /// Amplify app.
    waf_status: ?WafStatus = null,

    /// The Amazon Resource Name (ARN) for the web ACL associated with an Amplify
    /// app.
    web_acl_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .status_reason = "statusReason",
        .waf_status = "wafStatus",
        .web_acl_arn = "webAclArn",
    };
};
