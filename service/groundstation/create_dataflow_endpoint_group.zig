const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EndpointDetails = @import("endpoint_details.zig").EndpointDetails;

pub const CreateDataflowEndpointGroupInput = struct {
    /// Amount of time, in seconds, after a contact ends that the Ground Station
    /// Dataflow Endpoint Group will be in a `POSTPASS` state. A [Ground Station
    /// Dataflow Endpoint Group State Change
    /// event](https://docs.aws.amazon.com/ground-station/latest/ug/monitoring.automating-events.html) will be emitted when the Dataflow Endpoint Group enters and exits the `POSTPASS` state.
    contact_post_pass_duration_seconds: ?i32 = null,

    /// Amount of time, in seconds, before a contact starts that the Ground Station
    /// Dataflow Endpoint Group will be in a `PREPASS` state. A [Ground Station
    /// Dataflow Endpoint Group State Change
    /// event](https://docs.aws.amazon.com/ground-station/latest/ug/monitoring.automating-events.html) will be emitted when the Dataflow Endpoint Group enters and exits the `PREPASS` state.
    contact_pre_pass_duration_seconds: ?i32 = null,

    /// Endpoint details of each endpoint in the dataflow endpoint group. All
    /// dataflow endpoints within a single dataflow endpoint group must be of the
    /// same type. You cannot mix [ AWS Ground Station Agent
    /// endpoints](https://docs.aws.amazon.com/ground-station/latest/APIReference/API_AwsGroundStationAgentEndpoint.html) with [Dataflow endpoints](https://docs.aws.amazon.com/ground-station/latest/APIReference/API_DataflowEndpoint.html) in the same group. If your use case requires both types of endpoints, you must create separate dataflow endpoint groups for each type.
    endpoint_details: []const EndpointDetails,

    /// Tags of a dataflow endpoint group.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .contact_post_pass_duration_seconds = "contactPostPassDurationSeconds",
        .contact_pre_pass_duration_seconds = "contactPrePassDurationSeconds",
        .endpoint_details = "endpointDetails",
        .tags = "tags",
    };
};

pub const CreateDataflowEndpointGroupOutput = struct {
    /// UUID of a dataflow endpoint group.
    dataflow_endpoint_group_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .dataflow_endpoint_group_id = "dataflowEndpointGroupId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDataflowEndpointGroupInput, options: CallOptions) !CreateDataflowEndpointGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDataflowEndpointGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("groundstation", "GroundStation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/dataflowEndpointGroup";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.contact_post_pass_duration_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"contactPostPassDurationSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.contact_pre_pass_duration_seconds) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"contactPrePassDurationSeconds\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"endpointDetails\":");
    try aws.json.writeValue(@TypeOf(input.endpoint_details), input.endpoint_details, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDataflowEndpointGroupOutput {
    const result: CreateDataflowEndpointGroupOutput = try aws.json.parseJsonObject(
        CreateDataflowEndpointGroupOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
