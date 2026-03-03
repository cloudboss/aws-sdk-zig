const DataSourceToIndexFieldMapping = @import("data_source_to_index_field_mapping.zig").DataSourceToIndexFieldMapping;
const IssueSubEntity = @import("issue_sub_entity.zig").IssueSubEntity;
const DataSourceVpcConfiguration = @import("data_source_vpc_configuration.zig").DataSourceVpcConfiguration;

/// Provides the configuration information to connect to Jira as your data
/// source.
pub const JiraConfiguration = struct {
    /// A list of `DataSourceToIndexFieldMapping` objects that map attributes or
    /// field names of Jira attachments to Amazon Kendra index field names. To
    /// create
    /// custom fields, use the `UpdateIndex` API before you map to Jira fields. For
    /// more information, see [ Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The
    /// Jira data source field names must exist in your Jira custom metadata.
    attachment_field_mappings: ?[]const DataSourceToIndexFieldMapping = null,

    /// A list of `DataSourceToIndexFieldMapping` objects that map attributes or
    /// field names of Jira comments to Amazon Kendra index field names. To create
    /// custom
    /// fields, use the `UpdateIndex` API before you map to Jira fields. For more
    /// information, see [
    /// Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The Jira data source field names must exist in
    /// your Jira custom metadata.
    comment_field_mappings: ?[]const DataSourceToIndexFieldMapping = null,

    /// A list of regular expression patterns to exclude certain file paths, file
    /// names, and
    /// file types in your Jira data source. Files that match the patterns are
    /// excluded from the
    /// index. Files that don’t match the patterns are included in the index. If a
    /// file matches
    /// both an inclusion pattern and an exclusion pattern, the exclusion pattern
    /// takes
    /// precedence and the file isn't included in the index.
    exclusion_patterns: ?[]const []const u8 = null,

    /// A list of regular expression patterns to include certain file paths, file
    /// names, and
    /// file types in your Jira data source. Files that match the patterns are
    /// included in the
    /// index. Files that don't match the patterns are excluded from the index. If a
    /// file
    /// matches both an inclusion pattern and an exclusion pattern, the exclusion
    /// pattern takes
    /// precedence and the file isn't included in the index.
    inclusion_patterns: ?[]const []const u8 = null,

    /// A list of `DataSourceToIndexFieldMapping` objects that map attributes or
    /// field names of Jira issues to Amazon Kendra index field names. To create
    /// custom
    /// fields, use the `UpdateIndex` API before you map to Jira fields. For more
    /// information, see [
    /// Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The Jira data source field names must exist in
    /// your Jira custom metadata.
    issue_field_mappings: ?[]const DataSourceToIndexFieldMapping = null,

    /// Specify whether to crawl comments, attachments, and work logs. You can
    /// specify one or
    /// more of these options.
    issue_sub_entity_filter: ?[]const IssueSubEntity = null,

    /// Specify which issue types to crawl in your Jira data source. You can specify
    /// one or
    /// more of these options to crawl.
    issue_type: ?[]const []const u8 = null,

    /// The URL of the Jira account. For example,
    /// *company.atlassian.net*.
    jira_account_url: []const u8,

    /// Specify which projects to crawl in your Jira data source. You can specify
    /// one or more
    /// Jira project IDs.
    project: ?[]const []const u8 = null,

    /// A list of `DataSourceToIndexFieldMapping` objects that map attributes or
    /// field names of Jira projects to Amazon Kendra index field names. To create
    /// custom
    /// fields, use the `UpdateIndex` API before you map to Jira fields. For more
    /// information, see [
    /// Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The Jira data source field names must exist in
    /// your Jira custom metadata.
    project_field_mappings: ?[]const DataSourceToIndexFieldMapping = null,

    /// The Amazon Resource Name (ARN) of a secret in Secrets Manager contains the
    /// key-value pairs required to connect to your Jira data source. The secret
    /// must contain a
    /// JSON structure with the following keys:
    ///
    /// * jiraId—The Jira user name or email.
    ///
    /// * jiraCredentials—The Jira API token. For more information, see [Using a
    /// Jira data
    /// source](https://docs.aws.amazon.com/kendra/latest/dg/data-source-jira.html).
    secret_arn: []const u8,

    /// Specify which statuses to crawl in your Jira data source. You can specify
    /// one or more
    /// of these options to crawl.
    status: ?[]const []const u8 = null,

    /// `TRUE` to use the Jira change log to determine which documents require
    /// updating in the index. Depending on the change log's size, it may take
    /// longer for
    /// Amazon Kendra to use the change log than to scan all of your documents in
    /// Jira.
    use_change_log: bool = false,

    /// Configuration information for an Amazon Virtual Private Cloud to connect to
    /// your Jira. For
    /// more information, see [Configuring a
    /// VPC](https://docs.aws.amazon.com/kendra/latest/dg/vpc-configuration.html).
    vpc_configuration: ?DataSourceVpcConfiguration = null,

    /// A list of `DataSourceToIndexFieldMapping` objects that map attributes or
    /// field names of Jira work logs to Amazon Kendra index field names. To create
    /// custom
    /// fields, use the `UpdateIndex` API before you map to Jira fields. For more
    /// information, see [
    /// Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The Jira data source field names must exist in
    /// your Jira custom metadata.
    work_log_field_mappings: ?[]const DataSourceToIndexFieldMapping = null,

    pub const json_field_names = .{
        .attachment_field_mappings = "AttachmentFieldMappings",
        .comment_field_mappings = "CommentFieldMappings",
        .exclusion_patterns = "ExclusionPatterns",
        .inclusion_patterns = "InclusionPatterns",
        .issue_field_mappings = "IssueFieldMappings",
        .issue_sub_entity_filter = "IssueSubEntityFilter",
        .issue_type = "IssueType",
        .jira_account_url = "JiraAccountUrl",
        .project = "Project",
        .project_field_mappings = "ProjectFieldMappings",
        .secret_arn = "SecretArn",
        .status = "Status",
        .use_change_log = "UseChangeLog",
        .vpc_configuration = "VpcConfiguration",
        .work_log_field_mappings = "WorkLogFieldMappings",
    };
};
