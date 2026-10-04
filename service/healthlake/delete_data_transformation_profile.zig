const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const DeleteDataTransformationProfileInput = struct {
    /// The unique identifier of the profile to delete.
    profile_id: []const u8,

    pub const json_field_names = .{
        .profile_id = "ProfileId",
    };
};

pub const DeleteDataTransformationProfileOutput = struct {
    /// The timestamp when the profile was deleted.
    deletion_time: i64,

    /// The unique identifier of the deleted profile.
    profile_id: []const u8,

    /// The name of the deleted profile.
    profile_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .deletion_time = "DeletionTime",
        .profile_id = "ProfileId",
        .profile_name = "ProfileName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteDataTransformationProfileInput, options: CallOptions) !DeleteDataTransformationProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "healthlake", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteDataTransformationProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("healthlake", "HealthLake", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "HealthLake.DeleteDataTransformationProfile");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteDataTransformationProfileOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DeleteDataTransformationProfileOutput, body, allocator);
}
