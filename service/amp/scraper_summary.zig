const aws = @import("aws");

const Destination = @import("destination.zig").Destination;
const RoleConfiguration = @import("role_configuration.zig").RoleConfiguration;
const Source = @import("source.zig").Source;
const ScraperStatus = @import("scraper_status.zig").ScraperStatus;

/// The `ScraperSummary` structure contains a summary of the details about one
/// scraper in your account.
pub const ScraperSummary = struct {
    /// (Optional) A name associated with the scraper.
    alias: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the scraper.
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
    role_arn: []const u8,

    /// This structure displays information about the IAM roles used for
    /// cross-account scraping configuration.
    role_configuration: ?RoleConfiguration,

    /// The ID of the scraper.
    scraper_id: []const u8,

    /// The Amazon EKS cluster from which the scraper collects metrics.
    source: Source,

    /// A structure that contains the current status of the scraper.
    status: ScraperStatus,

    /// If there is a failure, the reason for the failure.
    status_reason: ?[]const u8,

    /// (Optional) The list of tag keys and values associated with the scraper.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .alias = "alias",
        .arn = "arn",
        .created_at = "createdAt",
        .destination = "destination",
        .last_modified_at = "lastModifiedAt",
        .role_arn = "roleArn",
        .role_configuration = "roleConfiguration",
        .scraper_id = "scraperId",
        .source = "source",
        .status = "status",
        .status_reason = "statusReason",
        .tags = "tags",
    };
};
