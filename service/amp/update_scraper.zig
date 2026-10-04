const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Destination = @import("destination.zig").Destination;
const RoleConfiguration = @import("role_configuration.zig").RoleConfiguration;
const ScrapeConfiguration = @import("scrape_configuration.zig").ScrapeConfiguration;
const ScraperStatus = @import("scraper_status.zig").ScraperStatus;

pub const UpdateScraperInput = struct {
    /// The new alias of the scraper.
    alias: ?[]const u8 = null,

    /// A unique identifier that you can provide to ensure the idempotency of the
    /// request. Case-sensitive.
    client_token: ?[]const u8 = null,

    /// The new Amazon Managed Service for Prometheus workspace to send metrics to.
    destination: ?Destination = null,

    /// Use this structure to enable cross-account access, so that you can use a
    /// target account to access Prometheus metrics from source accounts.
    role_configuration: ?RoleConfiguration = null,

    /// Contains the base-64 encoded YAML configuration for the scraper.
    ///
    /// For more information about configuring a scraper, see [Using an Amazon Web
    /// Services managed
    /// collector](https://docs.aws.amazon.com/prometheus/latest/userguide/AMP-collector-how-to.html) in the *Amazon Managed Service for Prometheus User Guide*.
    scrape_configuration: ?ScrapeConfiguration = null,

    /// The ID of the scraper to update.
    scraper_id: []const u8,

    pub const json_field_names = .{
        .alias = "alias",
        .client_token = "clientToken",
        .destination = "destination",
        .role_configuration = "roleConfiguration",
        .scrape_configuration = "scrapeConfiguration",
        .scraper_id = "scraperId",
    };
};

pub const UpdateScraperOutput = struct {
    /// The Amazon Resource Name (ARN) of the updated scraper.
    arn: []const u8,

    /// The ID of the updated scraper.
    scraper_id: []const u8,

    /// A structure that displays the current status of the scraper.
    status: ?ScraperStatus = null,

    /// The list of tag keys and values that are associated with the scraper.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .scraper_id = "scraperId",
        .status = "status",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateScraperInput, options: CallOptions) !UpdateScraperOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateScraperInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aps", "amp", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/scrapers/");
    try path_buf.appendSlice(allocator, input.scraper_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.alias) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"alias\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.destination) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"destination\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.role_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"roleConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.scrape_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"scrapeConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateScraperOutput {
    var result: UpdateScraperOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateScraperOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
