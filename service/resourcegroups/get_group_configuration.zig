const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GroupConfiguration = @import("group_configuration.zig").GroupConfiguration;

pub const GetGroupConfigurationInput = struct {
    /// The name or the Amazon resource name (ARN) of the resource group for which
    /// you want to retrive the service
    /// configuration.
    group: ?[]const u8 = null,

    pub const json_field_names = .{
        .group = "Group",
    };
};

pub const GetGroupConfigurationOutput = struct {
    /// A structure that describes the service configuration attached with the
    /// specified
    /// group. For details about the service configuration syntax, see [Service
    /// configurations for
    /// Resource
    /// Groups](https://docs.aws.amazon.com/ARG/latest/APIReference/about-slg.html).
    group_configuration: ?GroupConfiguration = null,

    pub const json_field_names = .{
        .group_configuration = "GroupConfiguration",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetGroupConfigurationInput, options: CallOptions) !GetGroupConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "resource-groups", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetGroupConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("resource-groups", "Resource Groups", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/get-group-configuration";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.group) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Group\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetGroupConfigurationOutput {
    var result: GetGroupConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetGroupConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
