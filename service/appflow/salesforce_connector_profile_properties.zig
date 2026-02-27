/// The connector-specific profile properties required when using Salesforce.
pub const SalesforceConnectorProfileProperties = struct {
    /// The location of the Salesforce resource.
    instance_url: ?[]const u8,

    /// Indicates whether the connector profile applies to a sandbox or production
    /// environment.
    is_sandbox_environment: bool = false,

    /// If the connection mode for the connector profile is private, this parameter
    /// sets whether
    /// Amazon AppFlow uses the private network to send metadata and authorization
    /// calls to
    /// Salesforce. Amazon AppFlow sends private calls through Amazon Web Services
    /// PrivateLink. These
    /// calls travel through Amazon Web Services infrastructure without being
    /// exposed to the public
    /// internet.
    ///
    /// Set either of the following values:
    ///
    /// **true**
    ///
    /// Amazon AppFlow sends all calls to Salesforce over the private network.
    ///
    /// These private calls are:
    ///
    /// * Calls to get metadata about your Salesforce records. This metadata
    ///   describes
    /// your Salesforce objects and their fields.
    ///
    /// * Calls to get or refresh access tokens that allow Amazon AppFlow to access
    /// your Salesforce records.
    ///
    /// * Calls to transfer your Salesforce records as part of a flow run.
    ///
    /// **false**
    ///
    /// The default value. Amazon AppFlow sends some calls to Salesforce privately
    /// and
    /// other calls over the public internet.
    ///
    /// The public calls are:
    ///
    /// * Calls to get metadata about your Salesforce records.
    ///
    /// * Calls to get or refresh access tokens.
    ///
    /// The private calls are:
    ///
    /// * Calls to transfer your Salesforce records as part of a flow run.
    use_private_link_for_metadata_and_authorization: bool = false,

    pub const json_field_names = .{
        .instance_url = "instanceUrl",
        .is_sandbox_environment = "isSandboxEnvironment",
        .use_private_link_for_metadata_and_authorization = "usePrivateLinkForMetadataAndAuthorization",
    };
};
