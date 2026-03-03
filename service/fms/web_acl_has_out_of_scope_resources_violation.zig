/// The violation details for a web ACL that's associated with at least one
/// resource that's out of scope of the Firewall Manager policy.
pub const WebACLHasOutOfScopeResourcesViolation = struct {
    /// An array of Amazon Resource Name (ARN) for the resources that are out of
    /// scope of the policy and are associated with the web ACL.
    out_of_scope_resource_list: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the web ACL.
    web_acl_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .out_of_scope_resource_list = "OutOfScopeResourceList",
        .web_acl_arn = "WebACLArn",
    };
};
