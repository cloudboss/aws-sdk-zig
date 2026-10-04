const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Component = @import("component.zig").Component;
const LatestVersionReferences = @import("latest_version_references.zig").LatestVersionReferences;

pub const GetComponentInput = struct {
    /// The Amazon Resource Name (ARN) of the component that you want to get. Regex
    /// requires
    /// the suffix `/\d+$`.
    component_build_version_arn: []const u8,

    pub const json_field_names = .{
        .component_build_version_arn = "componentBuildVersionArn",
    };
};

pub const GetComponentOutput = struct {
    /// The component object specified in the request.
    component: ?Component = null,

    /// The resource ARNs with different wildcard variations of semantic versioning.
    latest_version_references: ?LatestVersionReferences = null,

    /// The request ID that uniquely identifies this request.
    request_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .component = "component",
        .latest_version_references = "latestVersionReferences",
        .request_id = "requestId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetComponentInput, options: CallOptions) !GetComponentOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "imagebuilder", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetComponentInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("imagebuilder", "imagebuilder", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetComponent";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "componentBuildVersionArn=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.component_build_version_arn);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetComponentOutput {
    var result: GetComponentOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetComponentOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
