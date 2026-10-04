const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StoreType = @import("store_type.zig").StoreType;

pub const GetS3AccessPolicyInput = struct {
    /// The S3 access point ARN that has the access policy.
    s_3_access_point_arn: []const u8,

    pub const json_field_names = .{
        .s_3_access_point_arn = "s3AccessPointArn",
    };
};

pub const GetS3AccessPolicyOutput = struct {
    /// The S3 access point ARN that has the access policy.
    s_3_access_point_arn: ?[]const u8 = null,

    /// The current resource policy that controls S3 access on the store.
    s_3_access_policy: []const u8,

    /// The Amazon Web Services-generated Sequence Store or Reference Store ID.
    store_id: ?[]const u8 = null,

    /// The type of store associated with the access point.
    store_type: ?StoreType = null,

    /// The time when the policy was last updated.
    update_time: ?i64 = null,

    pub const json_field_names = .{
        .s_3_access_point_arn = "s3AccessPointArn",
        .s_3_access_policy = "s3AccessPolicy",
        .store_id = "storeId",
        .store_type = "storeType",
        .update_time = "updateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetS3AccessPolicyInput, options: CallOptions) !GetS3AccessPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "omics", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetS3AccessPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("omics", "Omics", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/s3accesspolicy/");
    try path_buf.appendSlice(allocator, input.s_3_access_point_arn);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetS3AccessPolicyOutput {
    var result: GetS3AccessPolicyOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetS3AccessPolicyOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
