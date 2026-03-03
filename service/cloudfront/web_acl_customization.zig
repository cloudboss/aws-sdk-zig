const CustomizationActionType = @import("customization_action_type.zig").CustomizationActionType;

/// The WAF web ACL customization specified for the distribution tenant.
pub const WebAclCustomization = struct {
    /// The action for the WAF web ACL customization. You can specify `override` to
    /// specify a separate WAF web ACL for the distribution tenant. If you specify
    /// `disable`, the distribution tenant won't have WAF web ACL protections and
    /// won't inherit from the multi-tenant distribution.
    action: CustomizationActionType,

    /// The Amazon Resource Name (ARN) of the WAF web ACL.
    arn: ?[]const u8 = null,
};
