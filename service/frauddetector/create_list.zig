const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const CreateListInput = struct {
    /// The description of the list.
    description: ?[]const u8 = null,

    /// The names of the elements, if providing. You can also create an empty list
    /// and add elements later using the
    /// [UpdateList](https://docs.aws.amazon.com/frauddetector/latest/api/API_Updatelist.html) API.
    elements: ?[]const []const u8 = null,

    /// The name of the list.
    name: []const u8,

    /// A collection of the key and value pairs.
    tags: ?[]const Tag = null,

    /// The variable type of the list. You can only assign the variable type with
    /// String data type. For more information, see
    /// [Variable
    /// types](https://docs.aws.amazon.com/frauddetector/latest/ug/create-a-variable.html#variable-types).
    variable_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .elements = "elements",
        .name = "name",
        .tags = "tags",
        .variable_type = "variableType",
    };
};

pub const CreateListOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateListInput, options: CallOptions) !CreateListOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "frauddetector", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateListInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("frauddetector", "FraudDetector", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSHawksNestServiceFacade.CreateList");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateListOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
