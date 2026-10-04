const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const IntegrationFilter = @import("integration_filter.zig").IntegrationFilter;
const Integration = @import("integration.zig").Integration;

pub const DescribeIntegrationsInput = struct {
    /// A list of key and values, to filter down the results. Supported keys are
    /// "Status", "IntegrationName", and "SourceArn". IntegrationName is limited to
    /// only one value.
    filters: ?[]const IntegrationFilter = null,

    /// The Amazon Resource Name (ARN) for the integration.
    integration_identifier: ?[]const u8 = null,

    /// A value that indicates the starting point for the next set of response
    /// records in a subsequent request.
    marker: ?[]const u8 = null,

    /// The total number of items to return in the output.
    max_records: ?i32 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .integration_identifier = "IntegrationIdentifier",
        .marker = "Marker",
        .max_records = "MaxRecords",
    };
};

pub const DescribeIntegrationsOutput = struct {
    /// A list of zero-ETL integrations.
    integrations: ?[]const Integration = null,

    /// A value that indicates the starting point for the next set of response
    /// records in a subsequent request.
    marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .integrations = "Integrations",
        .marker = "Marker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeIntegrationsInput, options: CallOptions) !DescribeIntegrationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeIntegrationsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.DescribeIntegrations");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeIntegrationsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeIntegrationsOutput, body, allocator);
}
