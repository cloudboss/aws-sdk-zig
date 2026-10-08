const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceTag = @import("resource_tag.zig").ResourceTag;

pub const TagResourceInput = struct {
    /// The Amazon Resource Name (ARN) of the resource. For a list of supported
    /// resources, see
    /// [ResourceTag](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_ResourceTag.html).
    resource_arn: []const u8,

    /// A list of tag key-value pairs to be added to the resource.
    ///
    /// Each tag consists of a key and a value, and each key must be unique for the
    /// resource. The
    /// following restrictions apply to resource tags:
    ///
    /// * Although the maximum number of array members is 200, you can assign a
    ///   maximum of 50
    /// user-tags to one resource. The remaining are reserved for Amazon Web
    /// Services use
    ///
    /// * The maximum length of a key is 128 characters
    ///
    /// * The maximum length of a value is 256 characters
    ///
    /// * Keys and values can only contain alphanumeric characters, spaces, and any
    ///   of the
    /// following: `_.:/=+@-`
    ///
    /// * Keys and values are case sensitive
    ///
    /// * Keys and values are trimmed for any leading or trailing whitespaces
    ///
    /// * Don’t use `aws:` as a prefix for your keys. This prefix is reserved for
    /// Amazon Web Services use
    resource_tags: []const ResourceTag,

    pub const json_field_names = .{
        .resource_arn = "ResourceArn",
        .resource_tags = "ResourceTags",
    };
};

pub const TagResourceOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TagResourceInput, options: CallOptions) !TagResourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ce", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: TagResourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ce", "Cost Explorer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.TagResource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TagResourceOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
