const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const WorkGroupConfigurationUpdates = @import("work_group_configuration_updates.zig").WorkGroupConfigurationUpdates;
const WorkGroupState = @import("work_group_state.zig").WorkGroupState;

pub const UpdateWorkGroupInput = struct {
    /// Contains configuration updates for an Athena SQL workgroup.
    configuration_updates: ?WorkGroupConfigurationUpdates = null,

    /// The workgroup description.
    description: ?[]const u8 = null,

    /// The workgroup state that will be updated for the given workgroup.
    state: ?WorkGroupState = null,

    /// The specified workgroup that will be updated.
    work_group: []const u8,

    pub const json_field_names = .{
        .configuration_updates = "ConfigurationUpdates",
        .description = "Description",
        .state = "State",
        .work_group = "WorkGroup",
    };
};

pub const UpdateWorkGroupOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateWorkGroupInput, options: CallOptions) !UpdateWorkGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "athena", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateWorkGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("athena", "Athena", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonAthena.UpdateWorkGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateWorkGroupOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
