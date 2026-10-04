const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DaemonRevision = @import("daemon_revision.zig").DaemonRevision;
const Failure = @import("failure.zig").Failure;

pub const DescribeDaemonRevisionsInput = struct {
    /// The ARN of the daemon revisions to describe. You can specify up to 20 ARNs.
    daemon_revision_arns: []const []const u8,

    pub const json_field_names = .{
        .daemon_revision_arns = "daemonRevisionArns",
    };
};

pub const DescribeDaemonRevisionsOutput = struct {
    /// The list of daemon revisions.
    daemon_revisions: ?[]const DaemonRevision = null,

    /// Any failures associated with the call.
    failures: ?[]const Failure = null,

    pub const json_field_names = .{
        .daemon_revisions = "daemonRevisions",
        .failures = "failures",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeDaemonRevisionsInput, options: CallOptions) !DescribeDaemonRevisionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeDaemonRevisionsInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.DescribeDaemonRevisions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeDaemonRevisionsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeDaemonRevisionsOutput, body, allocator);
}
