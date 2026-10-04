const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FailureInfo = @import("failure_info.zig").FailureInfo;

pub const TagResourcesInput = struct {
    /// Specifies the list of ARNs of the resources that you want to apply tags to.
    ///
    /// An ARN (Amazon Resource Name) uniquely identifies a resource. For more
    /// information,
    /// see [Amazon
    /// Resource Names (ARNs) and Amazon Web Services Service
    /// Namespaces](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html) in the *Amazon Web Services
    /// General Reference*.
    resource_arn_list: []const []const u8,

    /// Specifies a list of tags that you want to add to the specified resources. A
    /// tag
    /// consists of a key and a value that you define.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn_list = "ResourceARNList",
        .tags = "Tags",
    };
};

pub const TagResourcesOutput = struct {
    /// A map containing a key-value pair for each failed item that couldn't be
    /// tagged. The
    /// key is the ARN of the failed resource. The value is a `FailureInfo` object
    /// that contains an error code, a status code, and an error message. If there
    /// are no
    /// errors, the `FailedResourcesMap` is empty.
    failed_resources_map: ?[]const aws.map.MapEntry(FailureInfo) = null,

    pub const json_field_names = .{
        .failed_resources_map = "FailedResourcesMap",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TagResourcesInput, options: CallOptions) !TagResourcesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "tagging", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: TagResourcesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("tagging", "Resource Groups Tagging API", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ResourceGroupsTaggingAPI_20170126.TagResources");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TagResourcesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(TagResourcesOutput, body, allocator);
}
