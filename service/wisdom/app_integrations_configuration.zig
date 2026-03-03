/// Configuration information for Amazon AppIntegrations to automatically ingest
/// content.
pub const AppIntegrationsConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the AppIntegrations DataIntegration to use
    /// for ingesting content.
    ///
    /// * For [
    ///   Salesforce](https://developer.salesforce.com/docs/atlas.en-us.knowledge_dev.meta/knowledge_dev/sforce_api_objects_knowledge__kav.htm), your AppIntegrations DataIntegration must have an ObjectConfiguration if
    /// objectFields is not provided, including at least `Id`,
    /// `ArticleNumber`, `VersionNumber`, `Title`,
    /// `PublishStatus`, and `IsDeleted` as source fields.
    ///
    /// * For [
    ///   ServiceNow](https://developer.servicenow.com/dev.do#!/reference/api/rome/rest/knowledge-management-api), your AppIntegrations DataIntegration must have an ObjectConfiguration if
    /// objectFields is not provided, including at least `number`,
    /// `short_description`, `sys_mod_count`, `workflow_state`,
    /// and `active` as source fields.
    ///
    /// * For [
    /// Zendesk](https://developer.zendesk.com/api-reference/help_center/help-center-api/articles/), your AppIntegrations DataIntegration must have an ObjectConfiguration if
    /// `objectFields` is not provided, including at least `id`,
    /// `title`, `updated_at`, and `draft` as source fields.
    ///
    /// * For
    ///   [SharePoint](https://learn.microsoft.com/en-us/sharepoint/dev/sp-add-ins/sharepoint-net-server-csom-jsom-and-rest-api-index), your AppIntegrations DataIntegration must have a FileConfiguration,
    /// including only file extensions that are among `docx`, `pdf`,
    /// `html`, `htm`, and `txt`.
    ///
    /// * For [Amazon S3](https://aws.amazon.com/s3/), the
    /// ObjectConfiguration and FileConfiguration of your AppIntegrations
    /// DataIntegration must be null. The `SourceURI` of your
    /// DataIntegration must use the following format:
    /// `s3://your_s3_bucket_name`.
    ///
    /// The bucket policy of the corresponding S3 bucket must allow the Amazon Web
    /// Services
    /// principal `app-integrations.amazonaws.com` to perform
    /// `s3:ListBucket`, `s3:GetObject`, and `s3:GetBucketLocation`
    /// against the bucket.
    app_integration_arn: []const u8,

    /// The fields from the source that are made available to your agents in Wisdom.
    /// Optional if
    /// ObjectConfiguration is included in the provided DataIntegration.
    ///
    /// * For [
    ///   Salesforce](https://developer.salesforce.com/docs/atlas.en-us.knowledge_dev.meta/knowledge_dev/sforce_api_objects_knowledge__kav.htm), you must include at least `Id`,
    /// `ArticleNumber`, `VersionNumber`, `Title`,
    /// `PublishStatus`, and `IsDeleted`.
    ///
    /// * For [
    ///   ServiceNow](https://developer.servicenow.com/dev.do#!/reference/api/rome/rest/knowledge-management-api), you must include at least `number`,
    /// `short_description`, `sys_mod_count`, `workflow_state`,
    /// and `active`.
    ///
    /// * For [
    /// Zendesk](https://developer.zendesk.com/api-reference/help_center/help-center-api/articles/), you must include at least `id`, `title`,
    /// `updated_at`, and `draft`.
    ///
    /// Make sure to include additional fields. These fields are indexed and used to
    /// source
    /// recommendations.
    object_fields: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .app_integration_arn = "appIntegrationArn",
        .object_fields = "objectFields",
    };
};
