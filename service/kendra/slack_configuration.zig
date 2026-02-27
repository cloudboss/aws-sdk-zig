const DataSourceToIndexFieldMapping = @import("data_source_to_index_field_mapping.zig").DataSourceToIndexFieldMapping;
const SlackEntity = @import("slack_entity.zig").SlackEntity;
const DataSourceVpcConfiguration = @import("data_source_vpc_configuration.zig").DataSourceVpcConfiguration;

/// Provides the configuration information to connect to Slack as your data
/// source.
///
/// Amazon Kendra now supports an upgraded Slack connector.
///
/// You must now use the
/// [TemplateConfiguration](https://docs.aws.amazon.com/kendra/latest/APIReference/API_TemplateConfiguration.html) object instead of the
/// `SlackConfiguration` object to configure your connector.
///
/// Connectors configured using the older console and API architecture will
/// continue to
/// function as configured. However, you won’t be able to edit or update them.
/// If you want
/// to edit or update your connector configuration, you must create a new
/// connector.
///
/// We recommended migrating your connector workflow to the upgraded version.
/// Support for
/// connectors configured using the older architecture is scheduled to end by
/// June 2024.
pub const SlackConfiguration = struct {
    /// `TRUE` to index bot messages from your Slack workspace team.
    crawl_bot_message: bool = false,

    /// `TRUE` to exclude archived messages to index from your Slack workspace
    /// team.
    exclude_archived: bool = false,

    /// A list of regular expression patterns to exclude certain attached files in
    /// your Slack
    /// workspace team. Files that match the patterns are excluded from the index.
    /// Files that
    /// don’t match the patterns are included in the index. If a file matches both
    /// an inclusion
    /// and exclusion pattern, the exclusion pattern takes precedence and the file
    /// isn't
    /// included in the index.
    exclusion_patterns: ?[]const []const u8,

    /// A list of `DataSourceToIndexFieldMapping` objects that map Slack data
    /// source attributes or field names to Amazon Kendra index field names. To
    /// create
    /// custom fields, use the `UpdateIndex` API before you map to Slack fields. For
    /// more information, see [Mapping data source
    /// fields](https://docs.aws.amazon.com/kendra/latest/dg/field-mapping.html).
    /// The
    /// Slack data source field names must exist in your Slack custom metadata.
    field_mappings: ?[]const DataSourceToIndexFieldMapping,

    /// A list of regular expression patterns to include certain attached files in
    /// your Slack
    /// workspace team. Files that match the patterns are included in the index.
    /// Files that
    /// don't match the patterns are excluded from the index. If a file matches both
    /// an
    /// inclusion and exclusion pattern, the exclusion pattern takes precedence and
    /// the file
    /// isn't included in the index.
    inclusion_patterns: ?[]const []const u8,

    /// The number of hours for change log to look back from when you last
    /// synchronized your
    /// data. You can look back up to 7 days or 168 hours.
    ///
    /// Change log updates your index only if new content was added since you last
    /// synced your
    /// data. Updated or deleted content from before you last synced does not get
    /// updated in
    /// your index. To capture updated or deleted content before you last synced,
    /// set the
    /// `LookBackPeriod` to the number of hours you want change log to look
    /// back.
    look_back_period: ?i32,

    /// The list of private channel names from your Slack workspace team. You use
    /// this if you
    /// want to index specific private channels, not all private channels. You can
    /// also use
    /// regular expression patterns to filter private channels.
    private_channel_filter: ?[]const []const u8,

    /// The list of public channel names to index from your Slack workspace team.
    /// You use this
    /// if you want to index specific public channels, not all public channels. You
    /// can also use
    /// regular expression patterns to filter public channels.
    public_channel_filter: ?[]const []const u8,

    /// The Amazon Resource Name (ARN) of an Secrets Manager secret that contains
    /// the
    /// key-value pairs required to connect to your Slack workspace team. The secret
    /// must
    /// contain a JSON structure with the following keys:
    ///
    /// * slackToken—The user or bot token created in Slack. For more information
    /// on creating a token in Slack, see [Authentication for a Slack data
    /// source](https://docs.aws.amazon.com/kendra/latest/dg/data-source-slack.html#slack-authentication).
    secret_arn: []const u8,

    /// The date to start crawling your data from your Slack workspace team. The
    /// date must
    /// follow this format: `yyyy-mm-dd`.
    since_crawl_date: []const u8,

    /// Specify whether to index public channels, private channels, group messages,
    /// and direct
    /// messages. You can specify one or more of these options.
    slack_entity_list: []const SlackEntity,

    /// The identifier of the team in the Slack workspace. For example,
    /// *T0123456789*.
    ///
    /// You can find your team ID in the URL of the main page of your Slack
    /// workspace. When
    /// you log in to Slack via a browser, you are directed to the URL of the main
    /// page. For
    /// example, *https://app.slack.com/client/**T0123456789**/...*.
    team_id: []const u8,

    /// `TRUE` to use the Slack change log to determine which documents require
    /// updating in the index. Depending on the Slack change log's size, it may take
    /// longer for
    /// Amazon Kendra to use the change log than to scan all of your documents in
    /// Slack.
    use_change_log: bool = false,

    /// Configuration information for an Amazon Virtual Private Cloud to connect to
    /// your Slack. For
    /// more information, see [Configuring a
    /// VPC](https://docs.aws.amazon.com/kendra/latest/dg/vpc-configuration.html).
    vpc_configuration: ?DataSourceVpcConfiguration,

    pub const json_field_names = .{
        .crawl_bot_message = "CrawlBotMessage",
        .exclude_archived = "ExcludeArchived",
        .exclusion_patterns = "ExclusionPatterns",
        .field_mappings = "FieldMappings",
        .inclusion_patterns = "InclusionPatterns",
        .look_back_period = "LookBackPeriod",
        .private_channel_filter = "PrivateChannelFilter",
        .public_channel_filter = "PublicChannelFilter",
        .secret_arn = "SecretArn",
        .since_crawl_date = "SinceCrawlDate",
        .slack_entity_list = "SlackEntityList",
        .team_id = "TeamId",
        .use_change_log = "UseChangeLog",
        .vpc_configuration = "VpcConfiguration",
    };
};
