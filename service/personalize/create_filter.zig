const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const CreateFilterInput = struct {
    /// The ARN of the dataset group that the filter will belong to.
    dataset_group_arn: []const u8,

    /// The filter expression defines which items are included or excluded from
    /// recommendations. Filter expression must follow specific format rules.
    /// For information about filter expression structure and syntax, see
    /// [Filter
    /// expressions](https://docs.aws.amazon.com/personalize/latest/dg/filter-expressions.html).
    filter_expression: []const u8,

    /// The name of the filter to create.
    name: []const u8,

    /// A list of
    /// [tags](https://docs.aws.amazon.com/personalize/latest/dg/tagging-resources.html) to apply to the filter.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .dataset_group_arn = "datasetGroupArn",
        .filter_expression = "filterExpression",
        .name = "name",
        .tags = "tags",
    };
};

pub const CreateFilterOutput = struct {
    /// The ARN of the new filter.
    filter_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .filter_arn = "filterArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFilterInput, options: CallOptions) !CreateFilterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "personalize", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFilterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("personalize", "Personalize", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonPersonalize.CreateFilter");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFilterOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateFilterOutput, body, allocator);
}
