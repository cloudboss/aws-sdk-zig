const aws = @import("aws");

const Destination = @import("destination.zig").Destination;
const RoleConfiguration = @import("role_configuration.zig").RoleConfiguration;
const ScrapeConfiguration = @import("scrape_configuration.zig").ScrapeConfiguration;
const Source = @import("source.zig").Source;
const ScraperStatus = @import("scraper_status.zig").ScraperStatus;

/// The `ScraperDescription` structure contains the full details about one
/// scraper in your account.
pub const ScraperDescription = struct {
    /// (Optional) A name associated with the scraper.
    alias: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the scraper. For example,
    /// `arn:aws:aps:<region>:123456798012:scraper/s-example1-1234-abcd-5678-ef9012abcd34`.
    arn: []const u8,

    /// The date and time that the scraper was created.
    created_at: i64,

    /// The Amazon Managed Service for Prometheus workspace the scraper sends
    /// metrics to.
    destination: Destination,

    /// The date and time that the scraper was last modified.
    last_modified_at: i64,

    /// The Amazon Resource Name (ARN) of the IAM role that provides permissions for
    /// the scraper to discover and collect metrics on your behalf.
    ///
    /// For example,
    /// `arn:aws:iam::123456789012:role/service-role/AmazonGrafanaServiceRole-12example`.
    role_arn: []const u8,

    /// This structure displays information about the IAM roles used for
    /// cross-account scraping configuration.
    role_configuration: ?RoleConfiguration = null,

    /// The configuration in use by the scraper.
    scrape_configuration: ScrapeConfiguration,

    /// The ID of the scraper. For example,
    /// `s-example1-1234-abcd-5678-ef9012abcd34`.
    scraper_id: []const u8,

    /// The Amazon EKS cluster from which the scraper collects metrics.
    source: Source,

    /// A structure that contains the current status of the scraper.
    status: ScraperStatus,

    /// If there is a failure, the reason for the failure.
    status_reason: ?[]const u8 = null,

    /// (Optional) The list of tag keys and values associated with the scraper.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .alias = "alias",
        .arn = "arn",
        .created_at = "createdAt",
        .destination = "destination",
        .last_modified_at = "lastModifiedAt",
        .role_arn = "roleArn",
        .role_configuration = "roleConfiguration",
        .scrape_configuration = "scrapeConfiguration",
        .scraper_id = "scraperId",
        .source = "source",
        .status = "status",
        .status_reason = "statusReason",
        .tags = "tags",
    };
};
