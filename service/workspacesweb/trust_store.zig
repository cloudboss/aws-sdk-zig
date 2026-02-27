/// A trust store that can be associated with a web portal. A trust store
/// contains certificate authority (CA) certificates. Once associated with a web
/// portal, the browser in a streaming session will recognize certificates that
/// have been issued using any of the CAs in the trust store. If your
/// organization has internal websites that use certificates issued by private
/// CAs, you should add the private CA certificate to the trust store.
pub const TrustStore = struct {
    /// A list of web portal ARNs that this trust store is associated with.
    associated_portal_arns: ?[]const []const u8,

    /// The ARN of the trust store.
    trust_store_arn: []const u8,

    pub const json_field_names = .{
        .associated_portal_arns = "associatedPortalArns",
        .trust_store_arn = "trustStoreArn",
    };
};
