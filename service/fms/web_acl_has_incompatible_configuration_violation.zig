/// The violation details for a web ACL whose configuration is incompatible with
/// the Firewall Manager policy.
pub const WebACLHasIncompatibleConfigurationViolation = struct {
    /// Information about the problems that Firewall Manager encountered with the
    /// web ACL configuration.
    description: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the web ACL.
    web_acl_arn: ?[]const u8,

    pub const json_field_names = .{
        .description = "Description",
        .web_acl_arn = "WebACLArn",
    };
};
