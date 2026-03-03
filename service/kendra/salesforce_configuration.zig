const SalesforceChatterFeedConfiguration = @import("salesforce_chatter_feed_configuration.zig").SalesforceChatterFeedConfiguration;
const SalesforceKnowledgeArticleConfiguration = @import("salesforce_knowledge_article_configuration.zig").SalesforceKnowledgeArticleConfiguration;
const SalesforceStandardObjectAttachmentConfiguration = @import("salesforce_standard_object_attachment_configuration.zig").SalesforceStandardObjectAttachmentConfiguration;
const SalesforceStandardObjectConfiguration = @import("salesforce_standard_object_configuration.zig").SalesforceStandardObjectConfiguration;

/// Provides the configuration information to connect to Salesforce as your data
/// source.
pub const SalesforceConfiguration = struct {
    /// Configuration information for Salesforce chatter feeds.
    chatter_feed_configuration: ?SalesforceChatterFeedConfiguration = null,

    /// Indicates whether Amazon Kendra should index attachments to Salesforce
    /// objects.
    crawl_attachments: bool = false,

    /// A list of regular expression patterns to exclude certain documents in your
    /// Salesforce.
    /// Documents that match the patterns are excluded from the index. Documents
    /// that don't
    /// match the patterns are included in the index. If a document matches both an
    /// inclusion
    /// and exclusion pattern, the exclusion pattern takes precedence and the
    /// document isn't
    /// included in the index.
    ///
    /// The pattern is applied to the name of the attached file.
    exclude_attachment_file_patterns: ?[]const []const u8 = null,

    /// A list of regular expression patterns to include certain documents in your
    /// Salesforce.
    /// Documents that match the patterns are included in the index. Documents that
    /// don't match
    /// the patterns are excluded from the index. If a document matches both an
    /// inclusion and
    /// exclusion pattern, the exclusion pattern takes precedence and the document
    /// isn't
    /// included in the index.
    ///
    /// The pattern is applied to the name of the attached file.
    include_attachment_file_patterns: ?[]const []const u8 = null,

    /// Configuration information for the knowledge article types that Amazon Kendra
    /// indexes. Amazon Kendra indexes standard knowledge articles and the standard
    /// fields
    /// of knowledge articles, or the custom fields of custom knowledge articles,
    /// but not
    /// both.
    knowledge_article_configuration: ?SalesforceKnowledgeArticleConfiguration = null,

    /// The Amazon Resource Name (ARN) of an Secrets Managersecret that contains the
    /// key/value pairs required to connect to your Salesforce instance. The secret
    /// must contain
    /// a JSON structure with the following keys:
    ///
    /// * authenticationUrl - The OAUTH endpoint that Amazon Kendra connects to get
    /// an OAUTH token.
    ///
    /// * consumerKey - The application public key generated when you created your
    /// Salesforce application.
    ///
    /// * consumerSecret - The application private key generated when you created
    ///   your
    /// Salesforce application.
    ///
    /// * password - The password associated with the user logging in to the
    ///   Salesforce
    /// instance.
    ///
    /// * securityToken - The token associated with the user logging in to the
    /// Salesforce instance.
    ///
    /// * username - The user name of the user logging in to the Salesforce
    /// instance.
    secret_arn: []const u8,

    /// The instance URL for the Salesforce site that you want to index.
    server_url: []const u8,

    /// Configuration information for processing attachments to Salesforce standard
    /// objects.
    standard_object_attachment_configuration: ?SalesforceStandardObjectAttachmentConfiguration = null,

    /// Configuration of the Salesforce standard objects that Amazon Kendra
    /// indexes.
    standard_object_configurations: ?[]const SalesforceStandardObjectConfiguration = null,

    pub const json_field_names = .{
        .chatter_feed_configuration = "ChatterFeedConfiguration",
        .crawl_attachments = "CrawlAttachments",
        .exclude_attachment_file_patterns = "ExcludeAttachmentFilePatterns",
        .include_attachment_file_patterns = "IncludeAttachmentFilePatterns",
        .knowledge_article_configuration = "KnowledgeArticleConfiguration",
        .secret_arn = "SecretArn",
        .server_url = "ServerUrl",
        .standard_object_attachment_configuration = "StandardObjectAttachmentConfiguration",
        .standard_object_configurations = "StandardObjectConfigurations",
    };
};
