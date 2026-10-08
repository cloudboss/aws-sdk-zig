const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SpaceSettings = @import("space_settings.zig").SpaceSettings;

pub const UpdateSpaceInput = struct {
    /// The ID of the associated domain.
    domain_id: []const u8,

    /// The name of the space that appears in the Amazon SageMaker Studio UI.
    space_display_name: ?[]const u8 = null,

    /// The name of the space.
    space_name: []const u8,

    /// A collection of space settings.
    space_settings: ?SpaceSettings = null,

    pub const json_field_names = .{
        .domain_id = "DomainId",
        .space_display_name = "SpaceDisplayName",
        .space_name = "SpaceName",
        .space_settings = "SpaceSettings",
    };
};

pub const UpdateSpaceOutput = struct {
    /// The space's Amazon Resource Name (ARN).
    space_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .space_arn = "SpaceArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSpaceInput, options: CallOptions) !UpdateSpaceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSpaceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateSpace");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSpaceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateSpaceOutput, body, allocator);
}
