const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Filter = @import("filter.zig").Filter;
const Grant = @import("grant.zig").Grant;

pub const ListDistributedGrantsInput = struct {
    /// Filters to scope the results. The following filters are supported:
    ///
    /// * `LicenseArn`
    ///
    /// * `GrantStatus`
    ///
    /// * `GranteePrincipalARN`
    ///
    /// * `ProductSKU`
    ///
    /// * `LicenseIssuerName`
    filters: ?[]const Filter = null,

    /// Amazon Resource Names (ARNs) of the grants.
    grant_arns: ?[]const []const u8 = null,

    /// Maximum number of results to return in a single call.
    max_results: ?i32 = null,

    /// Token for the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .grant_arns = "GrantArns",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ListDistributedGrantsOutput = struct {
    /// Distributed grant details.
    grants: ?[]const Grant = null,

    /// Token for the next set of results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .grants = "Grants",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListDistributedGrantsInput, options: CallOptions) !ListDistributedGrantsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "license-manager", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListDistributedGrantsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("license-manager", "License Manager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSLicenseManager.ListDistributedGrants");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListDistributedGrantsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListDistributedGrantsOutput, body, allocator);
}
