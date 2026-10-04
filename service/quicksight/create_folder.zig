const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FolderType = @import("folder_type.zig").FolderType;
const ResourcePermission = @import("resource_permission.zig").ResourcePermission;
const SharingModel = @import("sharing_model.zig").SharingModel;
const Tag = @import("tag.zig").Tag;

pub const CreateFolderInput = struct {
    /// The ID for the Amazon Web Services account where you want to create the
    /// folder.
    aws_account_id: []const u8,

    /// The ID of the folder.
    folder_id: []const u8,

    /// The type of folder. By default, `folderType` is `SHARED`.
    folder_type: ?FolderType = null,

    /// The name of the folder.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the parent folder.
    ///
    /// `ParentFolderArn` can be null. An empty `parentFolderArn` creates a
    /// root-level folder.
    parent_folder_arn: ?[]const u8 = null,

    /// A structure that describes the principals and the resource-level permissions
    /// of a folder.
    ///
    /// To specify no permissions, omit `Permissions`.
    permissions: ?[]const ResourcePermission = null,

    /// An optional parameter that determines the sharing scope of the folder. The
    /// default value for this parameter is `ACCOUNT`.
    sharing_model: ?SharingModel = null,

    /// Tags for the folder.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .aws_account_id = "AwsAccountId",
        .folder_id = "FolderId",
        .folder_type = "FolderType",
        .name = "Name",
        .parent_folder_arn = "ParentFolderArn",
        .permissions = "Permissions",
        .sharing_model = "SharingModel",
        .tags = "Tags",
    };
};

pub const CreateFolderOutput = struct {
    /// The Amazon Resource Name (ARN) for the newly created folder.
    arn: ?[]const u8 = null,

    /// The folder ID for the newly created folder.
    folder_id: ?[]const u8 = null,

    /// The request ID for the newly created folder.
    request_id: ?[]const u8 = null,

    /// The HTTP status of the request.
    status: ?i32 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .folder_id = "FolderId",
        .request_id = "RequestId",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFolderInput, options: CallOptions) !CreateFolderOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "quicksight", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFolderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("quicksight", "QuickSight", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/accounts/");
    try path_buf.appendSlice(allocator, input.aws_account_id);
    try path_buf.appendSlice(allocator, "/folders/");
    try path_buf.appendSlice(allocator, input.folder_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.folder_type) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FolderType\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.parent_folder_arn) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ParentFolderArn\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.permissions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Permissions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.sharing_model) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SharingModel\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFolderOutput {
    var result: CreateFolderOutput = try aws.json.parseJsonObject(
        CreateFolderOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    result.status = @intCast(status);
    _ = headers;

    return result;
}
