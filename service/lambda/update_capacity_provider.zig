const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CapacityProviderScalingConfig = @import("capacity_provider_scaling_config.zig").CapacityProviderScalingConfig;
const CapacityProvider = @import("capacity_provider.zig").CapacityProvider;

pub const UpdateCapacityProviderInput = struct {
    /// The name of the capacity provider to update.
    capacity_provider_name: []const u8,

    /// The updated scaling configuration for the capacity provider.
    capacity_provider_scaling_config: ?CapacityProviderScalingConfig = null,

    pub const json_field_names = .{
        .capacity_provider_name = "CapacityProviderName",
        .capacity_provider_scaling_config = "CapacityProviderScalingConfig",
    };
};

pub const UpdateCapacityProviderOutput = struct {
    /// Information about the updated capacity provider.
    capacity_provider: ?CapacityProvider = null,

    pub const json_field_names = .{
        .capacity_provider = "CapacityProvider",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateCapacityProviderInput, options: CallOptions) !UpdateCapacityProviderOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lambda", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateCapacityProviderInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lambda", "Lambda", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2025-11-30/capacity-providers/");
    try path_buf.appendSlice(allocator, input.capacity_provider_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.capacity_provider_scaling_config) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CapacityProviderScalingConfig\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateCapacityProviderOutput {
    var result: UpdateCapacityProviderOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateCapacityProviderOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
