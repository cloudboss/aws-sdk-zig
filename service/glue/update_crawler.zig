const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LakeFormationConfiguration = @import("lake_formation_configuration.zig").LakeFormationConfiguration;
const LineageConfiguration = @import("lineage_configuration.zig").LineageConfiguration;
const RecrawlPolicy = @import("recrawl_policy.zig").RecrawlPolicy;
const SchemaChangePolicy = @import("schema_change_policy.zig").SchemaChangePolicy;
const CrawlerTargets = @import("crawler_targets.zig").CrawlerTargets;

pub const UpdateCrawlerInput = struct {
    /// The ID of the Data Catalog in which to store the crawler's output. If you
    /// omit this value, the existing value on the crawler is preserved.
    catalog_id: ?[]const u8 = null,

    /// A list of custom classifiers that the user
    /// has registered. By default, all built-in classifiers are included in a
    /// crawl,
    /// but these custom classifiers always override the default classifiers
    /// for a given classification.
    classifiers: ?[]const []const u8 = null,

    /// Crawler configuration information. This versioned JSON string allows users
    /// to specify aspects of a crawler's behavior.
    /// For more information, see [Setting crawler configuration
    /// options](https://docs.aws.amazon.com/glue/latest/dg/crawler-configuration.html).
    configuration: ?[]const u8 = null,

    /// The name of the `SecurityConfiguration` structure to be used by this
    /// crawler.
    crawler_security_configuration: ?[]const u8 = null,

    /// The Glue database where results are stored, such as:
    /// `arn:aws:daylight:us-east-1::database/sometable/*`.
    database_name: ?[]const u8 = null,

    /// A description of the new crawler.
    description: ?[]const u8 = null,

    /// Specifies Lake Formation configuration settings for the crawler.
    lake_formation_configuration: ?LakeFormationConfiguration = null,

    /// Specifies data lineage configuration settings for the crawler.
    lineage_configuration: ?LineageConfiguration = null,

    /// Name of the new crawler.
    name: []const u8,

    /// A policy that specifies whether to crawl the entire dataset again, or to
    /// crawl only folders that were added since the last crawler run.
    recrawl_policy: ?RecrawlPolicy = null,

    /// The IAM role or Amazon Resource Name (ARN) of an IAM role that is used by
    /// the new crawler
    /// to access customer resources.
    role: ?[]const u8 = null,

    /// A `cron` expression used to specify the schedule (see [Time-Based Schedules
    /// for Jobs and
    /// Crawlers](https://docs.aws.amazon.com/glue/latest/dg/monitor-data-warehouse-schedule.html). For example, to run
    /// something every day at 12:15 UTC, you would specify:
    /// `cron(15 12 * * ? *)`.
    schedule: ?[]const u8 = null,

    /// The policy for the crawler's update and deletion behavior.
    schema_change_policy: ?SchemaChangePolicy = null,

    /// The table prefix used for catalog tables that are created.
    table_prefix: ?[]const u8 = null,

    /// A list of targets to crawl.
    targets: ?CrawlerTargets = null,

    pub const json_field_names = .{
        .catalog_id = "CatalogId",
        .classifiers = "Classifiers",
        .configuration = "Configuration",
        .crawler_security_configuration = "CrawlerSecurityConfiguration",
        .database_name = "DatabaseName",
        .description = "Description",
        .lake_formation_configuration = "LakeFormationConfiguration",
        .lineage_configuration = "LineageConfiguration",
        .name = "Name",
        .recrawl_policy = "RecrawlPolicy",
        .role = "Role",
        .schedule = "Schedule",
        .schema_change_policy = "SchemaChangePolicy",
        .table_prefix = "TablePrefix",
        .targets = "Targets",
    };
};

pub const UpdateCrawlerOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCrawlerInput, options: CallOptions) !UpdateCrawlerOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

    var response = try client.config.http_client.sendRequestWithOptions(&request, client.options);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = try parseErrorResponse(client.allocator, response.body, response.status);
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCrawlerInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.UpdateCrawler");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCrawlerOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
