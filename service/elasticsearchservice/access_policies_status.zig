const OptionStatus = @import("option_status.zig").OptionStatus;

/// The configured access rules for the domain's document and search endpoints,
/// and the current status of those rules.
pub const AccessPoliciesStatus = struct {
    /// The access policy configured for the Elasticsearch domain. Access policies
    /// may be resource-based, IP-based, or IAM-based. See [
    /// Configuring Access
    /// Policies](http://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-createupdatedomains.html#es-createdomain-configure-access-policies)for more information.
    options: []const u8,

    /// The status of the access policy for the Elasticsearch domain. See
    /// `OptionStatus` for the status information that's included.
    status: OptionStatus,

    pub const json_field_names = .{
        .options = "Options",
        .status = "Status",
    };
};
