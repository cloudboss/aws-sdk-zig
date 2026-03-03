const LakeFormationConfiguration = @import("lake_formation_configuration.zig").LakeFormationConfiguration;
const LastCrawlInfo = @import("last_crawl_info.zig").LastCrawlInfo;
const LineageConfiguration = @import("lineage_configuration.zig").LineageConfiguration;
const RecrawlPolicy = @import("recrawl_policy.zig").RecrawlPolicy;
const Schedule = @import("schedule.zig").Schedule;
const SchemaChangePolicy = @import("schema_change_policy.zig").SchemaChangePolicy;
const CrawlerState = @import("crawler_state.zig").CrawlerState;
const CrawlerTargets = @import("crawler_targets.zig").CrawlerTargets;

/// Specifies a crawler program that examines a data source and uses classifiers
/// to try to
/// determine its schema. If successful, the crawler records metadata concerning
/// the data source
/// in the Glue Data Catalog.
pub const Crawler = struct {
    /// A list of UTF-8 strings that specify the custom classifiers that are
    /// associated
    /// with the crawler.
    classifiers: ?[]const []const u8 = null,

    /// Crawler configuration information. This versioned JSON string allows users
    /// to specify
    /// aspects of a crawler's behavior. For more information, see [Setting crawler
    /// configuration
    /// options](https://docs.aws.amazon.com/glue/latest/dg/crawler-configuration.html).
    configuration: ?[]const u8 = null,

    /// If the crawler is running, contains the total time elapsed since the last
    /// crawl
    /// began.
    crawl_elapsed_time: i64 = 0,

    /// The name of the `SecurityConfiguration` structure to be used by this
    /// crawler.
    crawler_security_configuration: ?[]const u8 = null,

    /// The time that the crawler was created.
    creation_time: ?i64 = null,

    /// The name of the database in which the crawler's output is stored.
    database_name: ?[]const u8 = null,

    /// A description of the crawler.
    description: ?[]const u8 = null,

    /// Specifies whether the crawler should use Lake Formation credentials for the
    /// crawler instead of the IAM role credentials.
    lake_formation_configuration: ?LakeFormationConfiguration = null,

    /// The status of the last crawl, and potentially error information if
    /// an error occurred.
    last_crawl: ?LastCrawlInfo = null,

    /// The time that the crawler was last updated.
    last_updated: ?i64 = null,

    /// A configuration that specifies whether data lineage is enabled for the
    /// crawler.
    lineage_configuration: ?LineageConfiguration = null,

    /// The name of the crawler.
    name: ?[]const u8 = null,

    /// A policy that specifies whether to crawl the entire dataset again, or to
    /// crawl only folders that were added since the last crawler run.
    recrawl_policy: ?RecrawlPolicy = null,

    /// The Amazon Resource Name (ARN) of an IAM role that's used to access customer
    /// resources,
    /// such as Amazon Simple Storage Service (Amazon S3) data.
    role: ?[]const u8 = null,

    /// For scheduled crawlers, the schedule when the crawler runs.
    schedule: ?Schedule = null,

    /// The policy that specifies update and delete behaviors for the crawler.
    schema_change_policy: ?SchemaChangePolicy = null,

    /// Indicates whether the crawler is running, or whether a run is pending.
    state: ?CrawlerState = null,

    /// The prefix added to the names of tables that are created.
    table_prefix: ?[]const u8 = null,

    /// A collection of targets to crawl.
    targets: ?CrawlerTargets = null,

    /// The version of the crawler.
    version: i64 = 0,

    pub const json_field_names = .{
        .classifiers = "Classifiers",
        .configuration = "Configuration",
        .crawl_elapsed_time = "CrawlElapsedTime",
        .crawler_security_configuration = "CrawlerSecurityConfiguration",
        .creation_time = "CreationTime",
        .database_name = "DatabaseName",
        .description = "Description",
        .lake_formation_configuration = "LakeFormationConfiguration",
        .last_crawl = "LastCrawl",
        .last_updated = "LastUpdated",
        .lineage_configuration = "LineageConfiguration",
        .name = "Name",
        .recrawl_policy = "RecrawlPolicy",
        .role = "Role",
        .schedule = "Schedule",
        .schema_change_policy = "SchemaChangePolicy",
        .state = "State",
        .table_prefix = "TablePrefix",
        .targets = "Targets",
        .version = "Version",
    };
};
