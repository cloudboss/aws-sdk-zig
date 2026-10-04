const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProtectedJob = @import("protected_job.zig").ProtectedJob;

pub const GetProtectedJobInput = struct {
    /// The identifier for a membership in a protected job instance.
    membership_identifier: []const u8,

    /// The identifier for the protected job instance.
    protected_job_identifier: []const u8,

    pub const json_field_names = .{
        .membership_identifier = "membershipIdentifier",
        .protected_job_identifier = "protectedJobIdentifier",
    };
};

pub const GetProtectedJobOutput = struct {
    /// The protected job metadata.
    protected_job: ?ProtectedJob = null,

    pub const json_field_names = .{
        .protected_job = "protectedJob",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetProtectedJobInput, options: CallOptions) !GetProtectedJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cleanrooms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetProtectedJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms", "CleanRooms", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memberships/");
    try path_buf.appendSlice(allocator, input.membership_identifier);
    try path_buf.appendSlice(allocator, "/protectedJobs/");
    try path_buf.appendSlice(allocator, input.protected_job_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetProtectedJobOutput {
    const result: GetProtectedJobOutput = try aws.json.parseJsonObject(
        GetProtectedJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
