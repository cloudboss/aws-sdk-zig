const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const OperatingSystem = @import("operating_system.zig").OperatingSystem;
const WorkspaceImageRequiredTenancy = @import("workspace_image_required_tenancy.zig").WorkspaceImageRequiredTenancy;
const WorkspaceImageState = @import("workspace_image_state.zig").WorkspaceImageState;

pub const CreateWorkspaceImageInput = struct {
    /// The description of the new WorkSpace image.
    description: []const u8,

    /// The name of the new WorkSpace image.
    name: []const u8,

    /// The tags that you want to add to the new WorkSpace image.
    /// To add tags when you're creating the image, you must create an IAM policy
    /// that grants
    /// your IAM user permission to use `workspaces:CreateTags`.
    tags: ?[]const Tag = null,

    /// The identifier of the source WorkSpace
    workspace_id: []const u8,

    pub const json_field_names = .{
        .description = "Description",
        .name = "Name",
        .tags = "Tags",
        .workspace_id = "WorkspaceId",
    };
};

pub const CreateWorkspaceImageOutput = struct {
    /// The date when the image was created.
    created: ?i64 = null,

    /// The description of the image.
    description: ?[]const u8 = null,

    /// The identifier of the new WorkSpace image.
    image_id: ?[]const u8 = null,

    /// The name of the image.
    name: ?[]const u8 = null,

    /// The operating system that the image is running.
    operating_system: ?OperatingSystem = null,

    /// The identifier of the Amazon Web Services account that owns the image.
    owner_account_id: ?[]const u8 = null,

    /// Specifies whether the image is running on dedicated hardware.
    /// When Bring Your Own License (BYOL) is enabled, this value is set
    /// to DEDICATED. For more information, see
    /// [
    /// Bring Your Own Windows Desktop
    /// Images.](https://docs.aws.amazon.com/workspaces/latest/adminguide/byol-windows-images.htm).
    required_tenancy: ?WorkspaceImageRequiredTenancy = null,

    /// The availability status of the image.
    state: ?WorkspaceImageState = null,

    pub const json_field_names = .{
        .created = "Created",
        .description = "Description",
        .image_id = "ImageId",
        .name = "Name",
        .operating_system = "OperatingSystem",
        .owner_account_id = "OwnerAccountId",
        .required_tenancy = "RequiredTenancy",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateWorkspaceImageInput, options: CallOptions) !CreateWorkspaceImageOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateWorkspaceImageInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "WorkspacesService.CreateWorkspaceImage");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateWorkspaceImageOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateWorkspaceImageOutput, body, allocator);
}
