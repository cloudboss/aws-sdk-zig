const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OwnershipSettings = @import("ownership_settings.zig").OwnershipSettings;
const SpaceSettings = @import("space_settings.zig").SpaceSettings;
const SpaceSharingSettings = @import("space_sharing_settings.zig").SpaceSharingSettings;
const Tag = @import("tag.zig").Tag;

pub const CreateSpaceInput = struct {
    /// The ID of the associated domain.
    domain_id: []const u8,

    /// A collection of ownership settings.
    ownership_settings: ?OwnershipSettings = null,

    /// The name of the space that appears in the SageMaker Studio UI.
    space_display_name: ?[]const u8 = null,

    /// The name of the space.
    space_name: []const u8,

    /// A collection of space settings.
    space_settings: ?SpaceSettings = null,

    /// A collection of space sharing settings.
    space_sharing_settings: ?SpaceSharingSettings = null,

    /// Tags to associated with the space. Each tag consists of a key and an
    /// optional value. Tag keys must be unique for each resource. Tags are
    /// searchable using the `Search` API.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .domain_id = "DomainId",
        .ownership_settings = "OwnershipSettings",
        .space_display_name = "SpaceDisplayName",
        .space_name = "SpaceName",
        .space_settings = "SpaceSettings",
        .space_sharing_settings = "SpaceSharingSettings",
        .tags = "Tags",
    };
};

pub const CreateSpaceOutput = struct {
    /// The space's Amazon Resource Name (ARN).
    space_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .space_arn = "SpaceArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSpaceInput, options: CallOptions) !CreateSpaceOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSpaceInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateSpace");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSpaceOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateSpaceOutput, body, allocator);
}
