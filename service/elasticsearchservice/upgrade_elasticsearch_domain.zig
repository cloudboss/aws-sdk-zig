const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChangeProgressDetails = @import("change_progress_details.zig").ChangeProgressDetails;

pub const UpgradeElasticsearchDomainInput = struct {
    domain_name: []const u8,

    /// This flag, when set to True, indicates that an Upgrade Eligibility Check
    /// needs to be performed.
    /// This will not actually perform the Upgrade.
    perform_check_only: ?bool = null,

    /// The version of Elasticsearch that you intend to upgrade the domain to.
    target_version: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
        .perform_check_only = "PerformCheckOnly",
        .target_version = "TargetVersion",
    };
};

pub const UpgradeElasticsearchDomainOutput = struct {
    change_progress_details: ?ChangeProgressDetails = null,

    domain_name: ?[]const u8 = null,

    /// This flag, when set to True, indicates that an Upgrade Eligibility Check
    /// needs to be performed.
    /// This will not actually perform the Upgrade.
    perform_check_only: ?bool = null,

    /// The version of Elasticsearch that you intend to upgrade the domain to.
    target_version: ?[]const u8 = null,

    pub const json_field_names = .{
        .change_progress_details = "ChangeProgressDetails",
        .domain_name = "DomainName",
        .perform_check_only = "PerformCheckOnly",
        .target_version = "TargetVersion",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpgradeElasticsearchDomainInput, options: CallOptions) !UpgradeElasticsearchDomainOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "es", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpgradeElasticsearchDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "Elasticsearch Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2015-01-01/es/upgradeDomain";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DomainName\":");
    try aws.json.writeValue(@TypeOf(input.domain_name), input.domain_name, allocator, &body_buf);
    has_prev = true;
    if (input.perform_check_only) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PerformCheckOnly\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TargetVersion\":");
    try aws.json.writeValue(@TypeOf(input.target_version), input.target_version, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpgradeElasticsearchDomainOutput {
    var result: UpgradeElasticsearchDomainOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpgradeElasticsearchDomainOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
