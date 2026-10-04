const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImageSetState = @import("image_set_state.zig").ImageSetState;
const ImageSetWorkflowStatus = @import("image_set_workflow_status.zig").ImageSetWorkflowStatus;
const Overrides = @import("overrides.zig").Overrides;
const StorageTier = @import("storage_tier.zig").StorageTier;

pub const GetImageSetInput = struct {
    /// The data store identifier.
    datastore_id: []const u8,

    /// The image set identifier.
    image_set_id: []const u8,

    /// The image set version identifier.
    version_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .datastore_id = "datastoreId",
        .image_set_id = "imageSetId",
        .version_id = "versionId",
    };
};

pub const GetImageSetOutput = struct {
    /// The timestamp when image set properties were created.
    created_at: ?i64 = null,

    /// The data store identifier.
    datastore_id: []const u8,

    /// The timestamp when the image set properties were deleted.
    deleted_at: ?i64 = null,

    /// The Amazon Resource Name (ARN) assigned to the image set.
    image_set_arn: ?[]const u8 = null,

    /// The image set identifier.
    image_set_id: []const u8,

    /// The image set state.
    image_set_state: ImageSetState,

    /// The image set workflow status.
    image_set_workflow_status: ?ImageSetWorkflowStatus = null,

    /// The flag to determine whether the image set is primary or not.
    is_primary: ?bool = null,

    /// When the image set was last accessed.
    last_accessed_at: ?i64 = null,

    /// The error message thrown if an image set action fails.
    message: ?[]const u8 = null,

    /// This object contains the details of any overrides used while creating a
    /// specific image set version. If an image set was copied or updated using the
    /// `force` flag, this object will contain the `forced` flag.
    overrides: ?Overrides = null,

    /// The storage tier of the image set.
    storage_tier: ?StorageTier = null,

    /// The timestamp when image set properties were updated.
    updated_at: ?i64 = null,

    /// The image set version identifier.
    version_id: []const u8,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .datastore_id = "datastoreId",
        .deleted_at = "deletedAt",
        .image_set_arn = "imageSetArn",
        .image_set_id = "imageSetId",
        .image_set_state = "imageSetState",
        .image_set_workflow_status = "imageSetWorkflowStatus",
        .is_primary = "isPrimary",
        .last_accessed_at = "lastAccessedAt",
        .message = "message",
        .overrides = "overrides",
        .storage_tier = "storageTier",
        .updated_at = "updatedAt",
        .version_id = "versionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetImageSetInput, options: CallOptions) !GetImageSetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "medical-imaging", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetImageSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("medical-imaging", "Medical Imaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/datastore/");
    try path_buf.appendSlice(allocator, input.datastore_id);
    try path_buf.appendSlice(allocator, "/imageSet/");
    try path_buf.appendSlice(allocator, input.image_set_id);
    try path_buf.appendSlice(allocator, "/getImageSet");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.version_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "version=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetImageSetOutput {
    var result: GetImageSetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetImageSetOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
