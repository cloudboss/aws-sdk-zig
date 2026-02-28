const DataSourceToIndexFieldMapping = @import("data_source_to_index_field_mapping.zig").DataSourceToIndexFieldMapping;
const GitHubDocumentCrawlProperties = @import("git_hub_document_crawl_properties.zig").GitHubDocumentCrawlProperties;
const OnPremiseConfiguration = @import("on_premise_configuration.zig").OnPremiseConfiguration;
const SaaSConfiguration = @import("saa_s_configuration.zig").SaaSConfiguration;
const Type = @import("type.zig").Type;
const DataSourceVpcConfiguration = @import("data_source_vpc_configuration.zig").DataSourceVpcConfiguration;

/// Provides the configuration information to connect to GitHub as your data
/// source.
///
/// Amazon Kendra now supports an upgraded GitHub connector.
///
/// You must now use the
/// [TemplateConfiguration](https://docs.aws.amazon.com/kendra/latest/APIReference/API_TemplateConfiguration.html) object instead of the
/// `GitHubConfiguration` object to configure your connector.
///
/// Connectors configured using the older console and API architecture will
/// continue
/// to function as configured. However, you won’t be able to edit or update
/// them. If you
/// want to edit or update your connector configuration, you must create a new
/// connector.
///
/// We recommended migrating your connector workflow to the upgraded version.
/// Support
/// for connectors configured using the older architecture is scheduled to end
/// by June
/// 2024.
pub const GitHubConfiguration = struct {
    /// A list of regular expression patterns to exclude certain file names in your
    /// GitHub
    /// repository or repositories. File names that match the patterns are excluded
    /// from the
    /// index. File names that don't match the patterns are included in the index.
    /// If a file
    /// matches both an exclusion and inclusion pattern, the exclusion pattern takes
    /// precedence
    /// and the file isn't included in the index.
    exclusion_file_name_patterns: ?[]const []const u8,

    /// A list of regular expression patterns to exclude certain file types in your
    /// GitHub
    /// repository or repositories. File types that match the patterns are excluded
    /// from the
    /// index. File types that don't match the patterns are included in the index.
    /// If a file
    /// matches both an exclusion and inclusion pattern, the exclusion pattern takes
    /// precedence
    /// and the file isn't included in the index.
    exclusion_file_type_patterns: ?[]const []const u8,

    /// A list of regular expression patterns to exclude certain folder names in
    /// your GitHub
    /// repository or repositories. Folder names that match the patterns are
    /// excluded from the
    /// index. Folder names that don't match the patterns are included in the index.
    /// If a folder
    /// matches both an exclusion and inclusion pattern, the exclusion pattern takes
    /// precedence
    /// and the folder isn't included in the index.
    exclusion_folder_name_patterns: ?[]const []const u8,

    /// A list of `DataSourceToIndexFieldMapping` objects that map attributes or
    /// field names of GitHub commits to Amazon Kendra index field names. To create
    /// custom
    /// fields, use the `UpdateIndex` API before you map to GitHub fields. For more
    /// information, see [Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The GitHub data source field names must exist
    /// in your GitHub custom metadata.
    git_hub_commit_configuration_field_mappings: ?[]const DataSourceToIndexFieldMapping,

    /// Configuration information to include certain types of GitHub content. You
    /// can
    /// configure to index repository files only, or also include issues and pull
    /// requests,
    /// comments, and comment attachments.
    git_hub_document_crawl_properties: ?GitHubDocumentCrawlProperties,

    /// A list of `DataSourceToIndexFieldMapping` objects that map attributes or
    /// field names of GitHub issue attachments to Amazon Kendra index field names.
    /// To
    /// create custom fields, use the `UpdateIndex` API before you map to GitHub
    /// fields. For more information, see [Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The
    /// GitHub data source field names must exist in your GitHub custom metadata.
    git_hub_issue_attachment_configuration_field_mappings: ?[]const DataSourceToIndexFieldMapping,

    /// A list of `DataSourceToIndexFieldMapping` objects that map attributes or
    /// field names of GitHub issue comments to Amazon Kendra index field names. To
    /// create
    /// custom fields, use the `UpdateIndex` API before you map to GitHub fields.
    /// For
    /// more information, see [Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The
    /// GitHub data source field names must exist in your GitHub custom metadata.
    git_hub_issue_comment_configuration_field_mappings: ?[]const DataSourceToIndexFieldMapping,

    /// A list of `DataSourceToIndexFieldMapping` objects that map attributes or
    /// field names of GitHub issues to Amazon Kendra index field names. To create
    /// custom
    /// fields, use the `UpdateIndex` API before you map to GitHub fields. For more
    /// information, see [Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The GitHub data source field names must exist
    /// in your GitHub custom metadata.
    git_hub_issue_document_configuration_field_mappings: ?[]const DataSourceToIndexFieldMapping,

    /// A list of `DataSourceToIndexFieldMapping` objects that map attributes or
    /// field names of GitHub pull request comments to Amazon Kendra index field
    /// names. To
    /// create custom fields, use the `UpdateIndex` API before you map to GitHub
    /// fields. For more information, see [Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The
    /// GitHub data source field names must exist in your GitHub custom metadata.
    git_hub_pull_request_comment_configuration_field_mappings: ?[]const DataSourceToIndexFieldMapping,

    /// A list of `DataSourceToIndexFieldMapping` objects that map attributes or
    /// field names of GitHub pull request attachments to Amazon Kendra index field
    /// names.
    /// To create custom fields, use the `UpdateIndex` API before you map to GitHub
    /// fields. For more information, see [Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The
    /// GitHub data source field names must exist in your GitHub custom metadata.
    git_hub_pull_request_document_attachment_configuration_field_mappings: ?[]const DataSourceToIndexFieldMapping,

    /// A list of `DataSourceToIndexFieldMapping` objects that map attributes or
    /// field names of GitHub pull requests to Amazon Kendra index field names. To
    /// create
    /// custom fields, use the `UpdateIndex` API before you map to GitHub fields.
    /// For
    /// more information, see [Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The
    /// GitHub data source field names must exist in your GitHub custom metadata.
    git_hub_pull_request_document_configuration_field_mappings: ?[]const DataSourceToIndexFieldMapping,

    /// A list of `DataSourceToIndexFieldMapping` objects that map GitHub
    /// repository attributes or field names to Amazon Kendra index field names. To
    /// create
    /// custom fields, use the `UpdateIndex` API before you map to GitHub fields.
    /// For
    /// more information, see [Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The
    /// GitHub data source field names must exist in your GitHub custom metadata.
    git_hub_repository_configuration_field_mappings: ?[]const DataSourceToIndexFieldMapping,

    /// A list of regular expression patterns to include certain file names in your
    /// GitHub
    /// repository or repositories. File names that match the patterns are included
    /// in the
    /// index. File names that don't match the patterns are excluded from the index.
    /// If a file
    /// matches both an inclusion and exclusion pattern, the exclusion pattern takes
    /// precedence
    /// and the file isn't included in the index.
    inclusion_file_name_patterns: ?[]const []const u8,

    /// A list of regular expression patterns to include certain file types in your
    /// GitHub
    /// repository or repositories. File types that match the patterns are included
    /// in the
    /// index. File types that don't match the patterns are excluded from the index.
    /// If a file
    /// matches both an inclusion and exclusion pattern, the exclusion pattern takes
    /// precedence
    /// and the file isn't included in the index.
    inclusion_file_type_patterns: ?[]const []const u8,

    /// A list of regular expression patterns to include certain folder names in
    /// your GitHub
    /// repository or repositories. Folder names that match the patterns are
    /// included in the
    /// index. Folder names that don't match the patterns are excluded from the
    /// index. If a
    /// folder matches both an inclusion and exclusion pattern, the exclusion
    /// pattern takes
    /// precedence and the folder isn't included in the index.
    inclusion_folder_name_patterns: ?[]const []const u8,

    /// Configuration information to connect to GitHub Enterprise Server (on
    /// premises).
    on_premise_configuration: ?OnPremiseConfiguration,

    /// A list of names of the specific repositories you want to index.
    repository_filter: ?[]const []const u8,

    /// Configuration information to connect to GitHub Enterprise Cloud (SaaS).
    saa_s_configuration: ?SaaSConfiguration,

    /// The Amazon Resource Name (ARN) of an Secrets Manager secret that contains
    /// the
    /// key-value pairs required to connect to your GitHub. The secret must contain
    /// a JSON
    /// structure with the following keys:
    ///
    /// * personalToken—The access token created in GitHub. For more information
    /// on creating a token in GitHub, see [Using a GitHub data
    /// source](https://docs.aws.amazon.com/kendra/latest/dg/data-source-github.html).
    secret_arn: []const u8,

    /// The type of GitHub service you want to connect to—GitHub Enterprise Cloud
    /// (SaaS) or GitHub Enterprise Server (on premises).
    @"type": ?Type,

    /// `TRUE` to use the GitHub change log to determine which documents require
    /// updating in the index. Depending on the GitHub change log's size, it may
    /// take longer for
    /// Amazon Kendra to use the change log than to scan all of your documents in
    /// GitHub.
    use_change_log: bool = false,

    /// Configuration information of an Amazon Virtual Private Cloud to connect to
    /// your GitHub. For
    /// more information, see [Configuring a
    /// VPC](https://docs.aws.amazon.com/kendra/latest/dg/vpc-configuration.html).
    vpc_configuration: ?DataSourceVpcConfiguration,

    pub const json_field_names = .{
        .exclusion_file_name_patterns = "ExclusionFileNamePatterns",
        .exclusion_file_type_patterns = "ExclusionFileTypePatterns",
        .exclusion_folder_name_patterns = "ExclusionFolderNamePatterns",
        .git_hub_commit_configuration_field_mappings = "GitHubCommitConfigurationFieldMappings",
        .git_hub_document_crawl_properties = "GitHubDocumentCrawlProperties",
        .git_hub_issue_attachment_configuration_field_mappings = "GitHubIssueAttachmentConfigurationFieldMappings",
        .git_hub_issue_comment_configuration_field_mappings = "GitHubIssueCommentConfigurationFieldMappings",
        .git_hub_issue_document_configuration_field_mappings = "GitHubIssueDocumentConfigurationFieldMappings",
        .git_hub_pull_request_comment_configuration_field_mappings = "GitHubPullRequestCommentConfigurationFieldMappings",
        .git_hub_pull_request_document_attachment_configuration_field_mappings = "GitHubPullRequestDocumentAttachmentConfigurationFieldMappings",
        .git_hub_pull_request_document_configuration_field_mappings = "GitHubPullRequestDocumentConfigurationFieldMappings",
        .git_hub_repository_configuration_field_mappings = "GitHubRepositoryConfigurationFieldMappings",
        .inclusion_file_name_patterns = "InclusionFileNamePatterns",
        .inclusion_file_type_patterns = "InclusionFileTypePatterns",
        .inclusion_folder_name_patterns = "InclusionFolderNamePatterns",
        .on_premise_configuration = "OnPremiseConfiguration",
        .repository_filter = "RepositoryFilter",
        .saa_s_configuration = "SaaSConfiguration",
        .secret_arn = "SecretArn",
        .@"type" = "Type",
        .use_change_log = "UseChangeLog",
        .vpc_configuration = "VpcConfiguration",
    };
};
