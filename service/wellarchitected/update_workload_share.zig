const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PermissionType = @import("permission_type.zig").PermissionType;
const WorkloadShare = @import("workload_share.zig").WorkloadShare;

pub const UpdateWorkloadShareInput = struct {
    permission_type: PermissionType,

    share_id: []const u8,

    workload_id: []const u8,

    pub const json_field_names = .{
        .permission_type = "PermissionType",
        .share_id = "ShareId",
        .workload_id = "WorkloadId",
    };
};

pub const UpdateWorkloadShareOutput = struct {
    workload_id: ?[]const u8 = null,

    workload_share: ?WorkloadShare = null,

    pub const json_field_names = .{
        .workload_id = "WorkloadId",
        .workload_share = "WorkloadShare",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWorkloadShareInput, options: CallOptions) !UpdateWorkloadShareOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "wellarchitected", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWorkloadShareInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wellarchitected", "WellArchitected", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workloads/");
    try path_buf.appendSlice(allocator, input.workload_id);
    try path_buf.appendSlice(allocator, "/shares/");
    try path_buf.appendSlice(allocator, input.share_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PermissionType\":");
    try aws.json.writeValue(@TypeOf(input.permission_type), input.permission_type, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWorkloadShareOutput {
    const result: UpdateWorkloadShareOutput = try aws.json.parseJsonObject(
        UpdateWorkloadShareOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
