const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TaskDefinitionField = @import("task_definition_field.zig").TaskDefinitionField;
const Tag = @import("tag.zig").Tag;
const TaskDefinition = @import("task_definition.zig").TaskDefinition;

pub const DescribeTaskDefinitionInput = struct {
    /// Determines whether to see the resource tags for the task definition. If
    /// `TAGS` is specified, the tags are included in the response. If this field is
    /// omitted, tags aren't included in the response.
    include: ?[]const TaskDefinitionField = null,

    /// The `family` for the latest `ACTIVE` revision, `family` and `revision`
    /// (`family:revision`) for a specific revision in the family, or full Amazon
    /// Resource Name (ARN) of the task definition to describe.
    task_definition: []const u8,

    pub const json_field_names = .{
        .include = "include",
        .task_definition = "taskDefinition",
    };
};

pub const DescribeTaskDefinitionOutput = struct {
    /// The metadata that's applied to the task definition to help you categorize
    /// and organize them. Each tag consists of a key and an optional value. You
    /// define both.
    ///
    /// The following basic restrictions apply to tags:
    ///
    /// * Maximum number of tags per resource - 50
    /// * For each resource, each tag key must be unique, and each tag key can have
    ///   only one value.
    /// * Maximum key length - 128 Unicode characters in UTF-8
    /// * Maximum value length - 256 Unicode characters in UTF-8
    /// * If your tagging schema is used across multiple services and resources,
    ///   remember that other services may have restrictions on allowed characters.
    ///   Generally allowed characters are: letters, numbers, and spaces
    ///   representable in UTF-8, and the following characters: + - = . _ : / @.
    /// * Tag keys and values are case-sensitive.
    /// * Do not use `aws:`, `AWS:`, or any upper or lowercase combination of such
    ///   as a prefix for either keys or values as it is reserved for Amazon Web
    ///   Services use. You cannot edit or delete tag keys or values with this
    ///   prefix. Tags with this prefix do not count against your tags per resource
    ///   limit.
    tags: ?[]const Tag = null,

    /// The full task definition description.
    task_definition: ?TaskDefinition = null,

    pub const json_field_names = .{
        .tags = "tags",
        .task_definition = "taskDefinition",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTaskDefinitionInput, options: CallOptions) !DescribeTaskDefinitionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTaskDefinitionInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonEC2ContainerServiceV20141113.DescribeTaskDefinition");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTaskDefinitionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeTaskDefinitionOutput, body, allocator);
}
