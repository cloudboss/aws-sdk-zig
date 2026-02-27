const OptionStatus = @import("option_status.zig").OptionStatus;

/// The configured access rules for the domain's search endpoint, and the
/// current status
/// of those rules.
pub const AccessPoliciesStatus = struct {
    /// The access policy configured for the domain. Access policies can be
    /// resource-based,
    /// IP-based, or IAM-based. For more information, see [Configuring access
    /// policies](https://docs.aws.amazon.com/opensearch-service/latest/developerguide/createupdatedomains.html#createdomain-configure-access-policies).
    options: []const u8,

    /// The status of the access policy for the domain.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
