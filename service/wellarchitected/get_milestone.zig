const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Milestone = @import("milestone.zig").Milestone;

pub const GetMilestoneInput = struct {
    milestone_number: i32,

    workload_id: []const u8,

    pub const json_field_names = .{
        .milestone_number = "MilestoneNumber",
        .workload_id = "WorkloadId",
    };
};

pub const GetMilestoneOutput = struct {
    milestone: ?Milestone = null,

    workload_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .milestone = "Milestone",
        .workload_id = "WorkloadId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetMilestoneInput, options: CallOptions) !GetMilestoneOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetMilestoneInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("wellarchitected", "WellArchitected", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/workloads/");
    try path_buf.appendSlice(allocator, input.workload_id);
    try path_buf.appendSlice(allocator, "/milestones/");
    try path_buf.appendSlice(allocator, input.milestone_number);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetMilestoneOutput {
    const result: GetMilestoneOutput = try aws.json.parseJsonObject(
        GetMilestoneOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
