const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Destination = @import("destination.zig").Destination;
const ExporterConfiguration = @import("exporter_configuration.zig").ExporterConfiguration;
const RoleConfiguration = @import("role_configuration.zig").RoleConfiguration;
const ScrapeConfiguration = @import("scrape_configuration.zig").ScrapeConfiguration;
const Source = @import("source.zig").Source;
const ScraperStatus = @import("scraper_status.zig").ScraperStatus;

pub const CreateScraperInput = struct {
    /// (optional) An alias to associate with the scraper. This is for your use, and
    /// does not need to be unique.
    alias: ?[]const u8 = null,

    /// (Optional) A unique, case-sensitive identifier that you can provide to
    /// ensure the idempotency of the request.
    client_token: ?[]const u8 = null,

    /// The destination where the scraper sends the collected metrics. Valid
    /// destinations are Amazon Managed Service for Prometheus workspaces and
    /// CloudWatch datasets.
    destination: Destination,

    /// The exporter configurations for the scraper. You can configure at most one
    /// Amazon OpenSearch Service domain. If you don't specify a value, the scraper
    /// is created without an exporter configuration.
    exporters: ?[]const ExporterConfiguration = null,

    /// Use this structure to enable cross-account access, so that you can use a
    /// target account to access Prometheus metrics from source accounts.
    role_configuration: ?RoleConfiguration = null,

    /// The configuration file to use in the new scraper. For more information, see
    /// [Scraper
    /// configuration](https://docs.aws.amazon.com/prometheus/latest/userguide/AMP-collector-how-to.html#AMP-collector-configuration) in the *Amazon Managed Service for Prometheus User Guide*.
    scrape_configuration: ScrapeConfiguration,

    /// The Amazon EKS or Amazon Web Services cluster from which the scraper will
    /// collect metrics.
    source: Source,

    /// (Optional) The list of tag keys and values to associate with the scraper.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .alias = "alias",
        .client_token = "clientToken",
        .destination = "destination",
        .exporters = "exporters",
        .role_configuration = "roleConfiguration",
        .scrape_configuration = "scrapeConfiguration",
        .source = "source",
        .tags = "tags",
    };
};

pub const CreateScraperOutput = struct {
    /// The Amazon Resource Name (ARN) of the new scraper.
    arn: []const u8,

    /// The ID of the new scraper.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateScraperInput, options: CallOptions) !CreateScraperOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateScraperInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("aps", "amp", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/scrapers";

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
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"destination\":");
    try aws.json.writeValue(@TypeOf(input.destination), input.destination, allocator, &body_buf);
    has_prev = true;
    if (input.exporters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"exporters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.role_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"roleConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"scrapeConfiguration\":");
    try aws.json.writeValue(@TypeOf(input.scrape_configuration), input.scrape_configuration, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"source\":");
    try aws.json.writeValue(@TypeOf(input.source), input.source, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateScraperOutput {
    const result: CreateScraperOutput = try aws.json.parseJsonObject(
        CreateScraperOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
