const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstanceOnboardingJobStatus = @import("instance_onboarding_job_status.zig").InstanceOnboardingJobStatus;

pub const GetInstanceOnboardingJobStatusInput = struct {
    connect_instance_id: []const u8,

    pub const json_field_names = .{
        .connect_instance_id = "connectInstanceId",
    };
};

pub const GetInstanceOnboardingJobStatusOutput = struct {
    connect_instance_onboarding_job_status: ?InstanceOnboardingJobStatus = null,

    pub const json_field_names = .{
        .connect_instance_onboarding_job_status = "connectInstanceOnboardingJobStatus",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetInstanceOnboardingJobStatusInput, options: CallOptions) !GetInstanceOnboardingJobStatusOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect-campaigns", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetInstanceOnboardingJobStatusInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect-campaigns", "ConnectCampaigns", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/connect-instance/");
    try path_buf.appendSlice(allocator, input.connect_instance_id);
    try path_buf.appendSlice(allocator, "/onboarding");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetInstanceOnboardingJobStatusOutput {
    var result: GetInstanceOnboardingJobStatusOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetInstanceOnboardingJobStatusOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
