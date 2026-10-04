/// The access control settings for a knowledge base. Use this structure to
/// enable or disable document-level access control lists (ACLs) that filter
/// query results based on the permissions from the source data connector.
pub const AccessControlConfiguration = struct {
    /// Specifies whether ACLs are enabled for the knowledge base.
    ///
    /// This setting works together with the data source connector's ACL crawling.
    /// To enforce document-level access control end to end, set `isACLEnabled` to
    /// `true` and enable ACL crawling on the connector. For example, for an Amazon
    /// S3 data source, set `accessControlConfiguration.crawlAcl` to `true` in the
    /// connector template. For more information, see `KbTemplateConfiguration`.
    /// Enabling only one of the two settings does not produce a fully ACL-enforced
    /// knowledge base.
    is_acl_enabled: ?bool = null,

    pub const json_field_names = .{
        .is_acl_enabled = "isACLEnabled",
    };
};
