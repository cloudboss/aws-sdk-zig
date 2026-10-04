const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstancePatchStateFilter = @import("instance_patch_state_filter.zig").InstancePatchStateFilter;
const InstancePatchState = @import("instance_patch_state.zig").InstancePatchState;

pub const DescribeInstancePatchStatesForPatchGroupInput = struct {
    /// Each entry in the array is a structure containing:
    ///
    /// * Key (string between 1 and 200 characters)
    ///
    /// * Values (array containing a single string)
    ///
    /// * Type (string "Equal", "NotEqual", "LessThan", "GreaterThan")
    filters: ?[]const InstancePatchStateFilter = null,

    /// The maximum number of patches to return (per page).
    max_results: ?i32 = null,

    /// The token for the next set of items to return. (You received this token from
    /// a previous
    /// call.)
    next_token: ?[]const u8 = null,

    /// The name of the patch group for which the patch state information should be
    /// retrieved.
    patch_group: []const u8,

    pub const json_field_names = .{
        .filters = "Filters",
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .patch_group = "PatchGroup",
    };
};

pub const DescribeInstancePatchStatesForPatchGroupOutput = struct {
    /// The high-level patch state for the requested managed nodes.
    instance_patch_states: ?[]const InstancePatchState = null,

    /// The token to use when requesting the next set of items. If there are no
    /// additional items to
    /// return, the string is empty.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_patch_states = "InstancePatchStates",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeInstancePatchStatesForPatchGroupInput, options: CallOptions) !DescribeInstancePatchStatesForPatchGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeInstancePatchStatesForPatchGroupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.DescribeInstancePatchStatesForPatchGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeInstancePatchStatesForPatchGroupOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeInstancePatchStatesForPatchGroupOutput, body, allocator);
}
