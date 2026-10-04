const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MetadataProperties = @import("metadata_properties.zig").MetadataProperties;
const ActionSource = @import("action_source.zig").ActionSource;
const ActionStatus = @import("action_status.zig").ActionStatus;
const Tag = @import("tag.zig").Tag;

pub const CreateActionInput = struct {
    /// The name of the action. Must be unique to your account in an Amazon Web
    /// Services Region.
    action_name: []const u8,

    /// The action type.
    action_type: []const u8,

    /// The description of the action.
    description: ?[]const u8 = null,

    metadata_properties: ?MetadataProperties = null,

    /// A list of properties to add to the action.
    properties: ?[]const aws.map.StringMapEntry = null,

    /// The source type, ID, and URI.
    source: ActionSource,

    /// The status of the action.
    status: ?ActionStatus = null,

    /// A list of tags to apply to the action.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .action_name = "ActionName",
        .action_type = "ActionType",
        .description = "Description",
        .metadata_properties = "MetadataProperties",
        .properties = "Properties",
        .source = "Source",
        .status = "Status",
        .tags = "Tags",
    };
};

pub const CreateActionOutput = struct {
    /// The Amazon Resource Name (ARN) of the action.
    action_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .action_arn = "ActionArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateActionInput, options: CallOptions) !CreateActionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateActionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateAction");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateActionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateActionOutput, body, allocator);
}
