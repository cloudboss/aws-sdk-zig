const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const RegisterPatchBaselineForPatchGroupInput = struct {
    /// The ID of the patch baseline to register with the patch group.
    baseline_id: []const u8,

    /// The name of the patch group to be registered with the patch baseline.
    patch_group: []const u8,

    pub const json_field_names = .{
        .baseline_id = "BaselineId",
        .patch_group = "PatchGroup",
    };
};

pub const RegisterPatchBaselineForPatchGroupOutput = struct {
    /// The ID of the patch baseline the patch group was registered with.
    baseline_id: ?[]const u8 = null,

    /// The name of the patch group registered with the patch baseline.
    patch_group: ?[]const u8 = null,

    pub const json_field_names = .{
        .baseline_id = "BaselineId",
        .patch_group = "PatchGroup",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: RegisterPatchBaselineForPatchGroupInput, options: CallOptions) !RegisterPatchBaselineForPatchGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: RegisterPatchBaselineForPatchGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.RegisterPatchBaselineForPatchGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !RegisterPatchBaselineForPatchGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(RegisterPatchBaselineForPatchGroupOutput, body, allocator);
}
