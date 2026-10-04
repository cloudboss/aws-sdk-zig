const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ValidationFinding = @import("validation_finding.zig").ValidationFinding;

pub const ValidateCloudConnectorInput = struct {
    /// The ID of the cloud connector to validate.
    cloud_connector_id: []const u8,

    /// The maximum number of validation findings to return.
    max_results: ?i32 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_connector_id = "CloudConnectorId",
        .max_results = "MaxResults",
        .next_token = "NextToken",
    };
};

pub const ValidateCloudConnectorOutput = struct {
    /// The token to use when requesting the next set of items.
    next_token: ?[]const u8 = null,

    /// A list of validation findings for the cloud connector.
    validation_findings: ?[]const ValidationFinding = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .validation_findings = "ValidationFindings",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ValidateCloudConnectorInput, options: CallOptions) !ValidateCloudConnectorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ValidateCloudConnectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.ValidateCloudConnector");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ValidateCloudConnectorOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ValidateCloudConnectorOutput, body, allocator);
}
