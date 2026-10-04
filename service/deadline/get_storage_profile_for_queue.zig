const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FileSystemLocation = @import("file_system_location.zig").FileSystemLocation;
const StorageProfileOperatingSystemFamily = @import("storage_profile_operating_system_family.zig").StorageProfileOperatingSystemFamily;

pub const GetStorageProfileForQueueInput = struct {
    /// The farm ID for the queue in storage profile.
    farm_id: []const u8,

    /// The queue ID the queue in the storage profile.
    queue_id: []const u8,

    /// The storage profile ID for the storage profile in the queue.
    storage_profile_id: []const u8,

    pub const json_field_names = .{
        .farm_id = "farmId",
        .queue_id = "queueId",
        .storage_profile_id = "storageProfileId",
    };
};

pub const GetStorageProfileForQueueOutput = struct {
    /// The display name of the storage profile connected to a queue.
    ///
    /// This field can store any content. Escape or encode this content before
    /// displaying it on a webpage or any other system that might interpret the
    /// content of this field.
    display_name: []const u8,

    /// The location of the files for the storage profile within the queue.
    file_system_locations: ?[]const FileSystemLocation = null,

    /// The operating system of the storage profile in the queue.
    os_family: StorageProfileOperatingSystemFamily,

    /// The storage profile ID.
    storage_profile_id: []const u8,

    pub const json_field_names = .{
        .display_name = "displayName",
        .file_system_locations = "fileSystemLocations",
        .os_family = "osFamily",
        .storage_profile_id = "storageProfileId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetStorageProfileForQueueInput, options: CallOptions) !GetStorageProfileForQueueOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "deadline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetStorageProfileForQueueInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("deadline", "deadline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2023-10-12/farms/");
    try path_buf.appendSlice(allocator, input.farm_id);
    try path_buf.appendSlice(allocator, "/queues/");
    try path_buf.appendSlice(allocator, input.queue_id);
    try path_buf.appendSlice(allocator, "/storage-profiles/");
    try path_buf.appendSlice(allocator, input.storage_profile_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetStorageProfileForQueueOutput {
    var result: GetStorageProfileForQueueOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetStorageProfileForQueueOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
