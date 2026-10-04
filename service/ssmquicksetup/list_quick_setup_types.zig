const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QuickSetupTypeOutput = @import("quick_setup_type_output.zig").QuickSetupTypeOutput;

pub const ListQuickSetupTypesInput = struct {};

pub const ListQuickSetupTypesOutput = struct {
    /// An array of Quick Setup types.
    quick_setup_type_list: ?[]const QuickSetupTypeOutput = null,

    pub const json_field_names = .{
        .quick_setup_type_list = "QuickSetupTypeList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListQuickSetupTypesInput, options: CallOptions) !ListQuickSetupTypesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm-quicksetup", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListQuickSetupTypesInput, config: *aws.Config) !aws.http.Request {
    _ = input;
    const endpoint = try config.getEndpointForService("ssm-quicksetup", "SSM QuickSetup", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/listQuickSetupTypes";

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListQuickSetupTypesOutput {
    var result: ListQuickSetupTypesOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListQuickSetupTypesOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
