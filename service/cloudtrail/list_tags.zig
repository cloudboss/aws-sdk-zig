const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceTag = @import("resource_tag.zig").ResourceTag;

pub const ListTagsInput = struct {
    /// Reserved for future use.
    next_token: ?[]const u8 = null,

    /// Specifies a list of trail, event data store, dashboard, or channel ARNs
    /// whose tags will be listed. The list
    /// has a limit of 20 ARNs.
    ///
    /// Example trail ARN format:
    /// `arn:aws:cloudtrail:us-east-2:123456789012:trail/MyTrail`
    ///
    /// Example event data store ARN format:
    /// `arn:aws:cloudtrail:us-east-2:123456789012:eventdatastore/EXAMPLE-f852-4e8f-8bd1-bcf6cEXAMPLE`
    ///
    /// Example dashboard ARN format:
    /// `arn:aws:cloudtrail:us-east-1:123456789012:dashboard/exampleDash`
    ///
    /// Example channel ARN format:
    /// `arn:aws:cloudtrail:us-east-2:123456789012:channel/01234567890`
    resource_id_list: []const []const u8,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resource_id_list = "ResourceIdList",
    };
};

pub const ListTagsOutput = struct {
    /// Reserved for future use.
    next_token: ?[]const u8 = null,

    /// A list of resource tags.
    resource_tag_list: ?[]const ResourceTag = null,

    pub const json_field_names = .{
        .next_token = "NextToken",
        .resource_tag_list = "ResourceTagList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTagsInput, options: CallOptions) !ListTagsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudtrail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTagsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudtrail", "CloudTrail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.ListTags");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTagsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListTagsOutput, body, allocator);
}
