const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EndpointDetails = @import("endpoint_details.zig").EndpointDetails;

pub const GetDataflowEndpointGroupInput = struct {
    /// UUID of a dataflow endpoint group.
    dataflow_endpoint_group_id: []const u8,

    pub const json_field_names = .{
        .dataflow_endpoint_group_id = "dataflowEndpointGroupId",
    };
};

pub const GetDataflowEndpointGroupOutput = struct {
    /// Amount of time, in seconds, after a contact ends that the Ground Station
    /// Dataflow Endpoint Group will be in a `POSTPASS` state. A Ground Station
    /// Dataflow Endpoint Group State Change event will be emitted when the Dataflow
    /// Endpoint Group enters and exits the `POSTPASS` state.
    contact_post_pass_duration_seconds: ?i32 = null,

    /// Amount of time, in seconds, before a contact starts that the Ground Station
    /// Dataflow Endpoint Group will be in a `PREPASS` state. A Ground Station
    /// Dataflow Endpoint Group State Change event will be emitted when the Dataflow
    /// Endpoint Group enters and exits the `PREPASS` state.
    contact_pre_pass_duration_seconds: ?i32 = null,

    /// ARN of a dataflow endpoint group.
    dataflow_endpoint_group_arn: ?[]const u8 = null,

    /// UUID of a dataflow endpoint group.
    dataflow_endpoint_group_id: ?[]const u8 = null,

    /// Details of a dataflow endpoint.
    endpoints_details: ?[]const EndpointDetails = null,

    /// Tags assigned to a dataflow endpoint group.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .contact_post_pass_duration_seconds = "contactPostPassDurationSeconds",
        .contact_pre_pass_duration_seconds = "contactPrePassDurationSeconds",
        .dataflow_endpoint_group_arn = "dataflowEndpointGroupArn",
        .dataflow_endpoint_group_id = "dataflowEndpointGroupId",
        .endpoints_details = "endpointsDetails",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDataflowEndpointGroupInput, options: CallOptions) !GetDataflowEndpointGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "groundstation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDataflowEndpointGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("groundstation", "GroundStation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/dataflowEndpointGroup/");
    try path_buf.appendSlice(allocator, input.dataflow_endpoint_group_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDataflowEndpointGroupOutput {
    var result: GetDataflowEndpointGroupOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetDataflowEndpointGroupOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
