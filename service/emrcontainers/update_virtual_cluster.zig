const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SchedulerConfiguration = @import("scheduler_configuration.zig").SchedulerConfiguration;
const VirtualCluster = @import("virtual_cluster.zig").VirtualCluster;

pub const UpdateVirtualClusterInput = struct {
    /// A unique, case-sensitive identifier that you provide to ensure that the
    /// operation
    /// completes no more than one time. If this token matches a previous request,
    /// the service
    /// ignores the request, but does not return an error.
    client_token: []const u8,

    /// The ID of the virtual cluster to update.
    id: []const u8,

    /// The scheduler configuration to apply to the virtual cluster. The new
    /// configuration fully
    /// replaces the existing one. If you omit a field, the corresponding limit is
    /// removed.
    scheduler_configuration: ?SchedulerConfiguration = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .id = "id",
        .scheduler_configuration = "schedulerConfiguration",
    };
};

pub const UpdateVirtualClusterOutput = struct {
    /// The updated virtual cluster.
    virtual_cluster: ?VirtualCluster = null,

    pub const json_field_names = .{
        .virtual_cluster = "virtualCluster",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateVirtualClusterInput, options: CallOptions) !UpdateVirtualClusterOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "emr-containers", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateVirtualClusterInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("emr-containers", "EMR containers", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/virtualclusters/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientToken\":");
    try aws.json.writeValue(@TypeOf(input.client_token), input.client_token, allocator, &body_buf);
    has_prev = true;
    if (input.scheduler_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"schedulerConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateVirtualClusterOutput {
    const result: UpdateVirtualClusterOutput = try aws.json.parseJsonObject(
        UpdateVirtualClusterOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
