const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ScraperLoggingDestination = @import("scraper_logging_destination.zig").ScraperLoggingDestination;
const ScraperComponent = @import("scraper_component.zig").ScraperComponent;
const ScraperLoggingConfigurationStatus = @import("scraper_logging_configuration_status.zig").ScraperLoggingConfigurationStatus;

pub const DescribeScraperLoggingConfigurationInput = struct {
    /// The ID of the scraper whose logging configuration will be described.
    scraper_id: []const u8,

    pub const json_field_names = .{
        .scraper_id = "scraperId",
    };
};

pub const DescribeScraperLoggingConfigurationOutput = struct {
    /// The destination where scraper logs are sent.
    logging_destination: ?ScraperLoggingDestination = null,

    /// The date and time when the logging configuration was last modified.
    modified_at: i64,

    /// The list of scraper components configured for logging.
    scraper_components: ?[]const ScraperComponent = null,

    /// The ID of the scraper.
    scraper_id: []const u8,

    /// The status of the scraper logging configuration.
    status: ?ScraperLoggingConfigurationStatus = null,

    pub const json_field_names = .{
        .logging_destination = "loggingDestination",
        .modified_at = "modifiedAt",
        .scraper_components = "scraperComponents",
        .scraper_id = "scraperId",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeScraperLoggingConfigurationInput, options: CallOptions) !DescribeScraperLoggingConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "aps", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeScraperLoggingConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aps", "amp", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/scrapers/");
    try path_buf.appendSlice(allocator, input.scraper_id);
    try path_buf.appendSlice(allocator, "/logging-configuration");
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeScraperLoggingConfigurationOutput {
    const result: DescribeScraperLoggingConfigurationOutput = try aws.json.parseJsonObject(
        DescribeScraperLoggingConfigurationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
