const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComputeType = @import("compute_type.zig").ComputeType;
const RootStorage = @import("root_storage.zig").RootStorage;
const Tag = @import("tag.zig").Tag;
const UserStorage = @import("user_storage.zig").UserStorage;
const WorkspaceBundle = @import("workspace_bundle.zig").WorkspaceBundle;

pub const CreateWorkspaceBundleInput = struct {
    /// The description of the bundle.
    bundle_description: []const u8,

    /// The name of the bundle.
    bundle_name: []const u8,

    compute_type: ComputeType,

    /// The identifier of the image that is used to create the bundle.
    image_id: []const u8,

    root_storage: ?RootStorage = null,

    /// The tags associated with the bundle.
    ///
    /// To add tags at the same time when you're creating the bundle, you must
    /// create an IAM policy that
    /// grants your IAM user permissions to use `workspaces:CreateTags`.
    tags: ?[]const Tag = null,

    user_storage: UserStorage,

    pub const json_field_names = .{
        .bundle_description = "BundleDescription",
        .bundle_name = "BundleName",
        .compute_type = "ComputeType",
        .image_id = "ImageId",
        .root_storage = "RootStorage",
        .tags = "Tags",
        .user_storage = "UserStorage",
    };
};

pub const CreateWorkspaceBundleOutput = struct {
    workspace_bundle: ?WorkspaceBundle = null,

    pub const json_field_names = .{
        .workspace_bundle = "WorkspaceBundle",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWorkspaceBundleInput, options: CallOptions) !CreateWorkspaceBundleOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWorkspaceBundleInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkspacesService.CreateWorkspaceBundle");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWorkspaceBundleOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateWorkspaceBundleOutput, body, allocator);
}
