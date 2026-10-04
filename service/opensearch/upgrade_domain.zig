const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ChangeProgressDetails = @import("change_progress_details.zig").ChangeProgressDetails;

pub const UpgradeDomainInput = struct {
    /// Only supports the `override_main_response_version` parameter and not other
    /// advanced options. You can only include this option when upgrading to an
    /// OpenSearch
    /// version. Specifies whether the domain reports its version as 7.10 so that it
    /// continues
    /// to work with Elasticsearch OSS clients and plugins.
    advanced_options: ?[]const aws.map.StringMapEntry = null,

    /// Name of the OpenSearch Service domain that you want to upgrade.
    domain_name: []const u8,

    /// When true, indicates that an upgrade eligibility check needs to be
    /// performed. Does not
    /// actually perform the upgrade.
    perform_check_only: ?bool = null,

    /// OpenSearch or Elasticsearch version to which you want to upgrade, in the
    /// format
    /// Opensearch_X.Y or Elasticsearch_X.Y.
    target_version: []const u8,

    pub const json_field_names = .{
        .advanced_options = "AdvancedOptions",
        .domain_name = "DomainName",
        .perform_check_only = "PerformCheckOnly",
        .target_version = "TargetVersion",
    };
};

pub const UpgradeDomainOutput = struct {
    /// The advanced options configuration for the domain.
    advanced_options: ?[]const aws.map.StringMapEntry = null,

    /// Container for information about a configuration change happening on a
    /// domain.
    change_progress_details: ?ChangeProgressDetails = null,

    /// The name of the domain that was upgraded.
    domain_name: ?[]const u8 = null,

    /// When true, indicates that an upgrade eligibility check was performed.
    perform_check_only: ?bool = null,

    /// OpenSearch or Elasticsearch version that the domain was upgraded to.
    target_version: ?[]const u8 = null,

    /// The unique identifier of the domain upgrade.
    upgrade_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .advanced_options = "AdvancedOptions",
        .change_progress_details = "ChangeProgressDetails",
        .domain_name = "DomainName",
        .perform_check_only = "PerformCheckOnly",
        .target_version = "TargetVersion",
        .upgrade_id = "UpgradeId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpgradeDomainInput, options: CallOptions) !UpgradeDomainOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpgradeDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("es", "OpenSearch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2021-01-01/opensearch/upgradeDomain";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.advanced_options) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AdvancedOptions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpgradeDomainOutput {
    var result: UpgradeDomainOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpgradeDomainOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
