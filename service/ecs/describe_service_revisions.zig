const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Failure = @import("failure.zig").Failure;
const ServiceRevision = @import("service_revision.zig").ServiceRevision;

pub const DescribeServiceRevisionsInput = struct {
    /// The ARN of the service revision.
    ///
    /// You can specify a maximum of 20 ARNs.
    ///
    /// You can call
    /// [ListServiceDeployments](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ListServiceDeployments.html) to get the ARNs.
    service_revision_arns: []const []const u8,

    pub const json_field_names = .{
        .service_revision_arns = "serviceRevisionArns",
    };
};

pub const DescribeServiceRevisionsOutput = struct {
    /// Any failures associated with the call.
    failures: ?[]const Failure = null,

    /// The list of service revisions described.
    service_revisions: ?[]const ServiceRevision = null,

    pub const json_field_names = .{
        .failures = "failures",
        .service_revisions = "serviceRevisions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeServiceRevisionsInput, options: CallOptions) !DescribeServiceRevisionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ecs", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeServiceRevisionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ecs", "ECS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.DescribeServiceRevisions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeServiceRevisionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeServiceRevisionsOutput, body, allocator);
}
