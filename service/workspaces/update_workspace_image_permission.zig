const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const UpdateWorkspaceImagePermissionInput = struct {
    /// The permission to copy the image. This permission can be revoked only after
    /// an image has
    /// been shared.
    allow_copy_image: bool,

    /// The identifier of the image.
    image_id: []const u8,

    /// The identifier of the Amazon Web Services account to share or unshare the
    /// image
    /// with.
    ///
    /// Before sharing the image, confirm that you are sharing to the correct Amazon
    /// Web Services account ID.
    shared_account_id: []const u8,

    pub const json_field_names = .{
        .allow_copy_image = "AllowCopyImage",
        .image_id = "ImageId",
        .shared_account_id = "SharedAccountId",
    };
};

pub const UpdateWorkspaceImagePermissionOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWorkspaceImagePermissionInput, options: CallOptions) !UpdateWorkspaceImagePermissionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "workspaces", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWorkspaceImagePermissionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("workspaces", "WorkSpaces", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "WorkspacesService.UpdateWorkspaceImagePermission");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWorkspaceImagePermissionOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
