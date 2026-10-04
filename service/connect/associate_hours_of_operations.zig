const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ParentHoursOfOperationConfig = @import("parent_hours_of_operation_config.zig").ParentHoursOfOperationConfig;

pub const AssociateHoursOfOperationsInput = struct {
    /// The identifier of the child hours of operation.
    hours_of_operation_id: []const u8,

    /// The identifier of the Amazon Connect instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in
    /// the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    /// The Amazon Resource Names (ARNs) of the parent hours of operation resources
    /// to associate with the child hours of operation resource.
    parent_hours_of_operation_configs: []const ParentHoursOfOperationConfig,

    pub const json_field_names = .{
        .hours_of_operation_id = "HoursOfOperationId",
        .instance_id = "InstanceId",
        .parent_hours_of_operation_configs = "ParentHoursOfOperationConfigs",
    };
};

pub const AssociateHoursOfOperationsOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateHoursOfOperationsInput, options: CallOptions) !AssociateHoursOfOperationsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateHoursOfOperationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/hours-of-operations/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.hours_of_operation_id);
    try path_buf.appendSlice(allocator, "/associate-hours");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ParentHoursOfOperationConfigs\":");
    try aws.json.writeValue(@TypeOf(input.parent_hours_of_operation_configs), input.parent_hours_of_operation_configs, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateHoursOfOperationsOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: AssociateHoursOfOperationsOutput = .{};

    return result;
}
