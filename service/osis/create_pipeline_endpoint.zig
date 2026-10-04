const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PipelineEndpointVpcOptions = @import("pipeline_endpoint_vpc_options.zig").PipelineEndpointVpcOptions;
const PipelineEndpointStatus = @import("pipeline_endpoint_status.zig").PipelineEndpointStatus;

pub const CreatePipelineEndpointInput = struct {
    /// The Amazon Resource Name (ARN) of the pipeline to create the endpoint for.
    pipeline_arn: []const u8,

    /// Container for the VPC configuration for the pipeline endpoint, including
    /// subnet IDs and
    /// security group IDs.
    vpc_options: PipelineEndpointVpcOptions,

    pub const json_field_names = .{
        .pipeline_arn = "PipelineArn",
        .vpc_options = "VpcOptions",
    };
};

pub const CreatePipelineEndpointOutput = struct {
    /// The unique identifier of the pipeline endpoint.
    endpoint_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the pipeline associated with the endpoint.
    pipeline_arn: ?[]const u8 = null,

    /// The current status of the pipeline endpoint.
    status: ?PipelineEndpointStatus = null,

    /// The ID of the VPC where the pipeline endpoint was created.
    vpc_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .endpoint_id = "EndpointId",
        .pipeline_arn = "PipelineArn",
        .status = "Status",
        .vpc_id = "VpcId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreatePipelineEndpointInput, options: CallOptions) !CreatePipelineEndpointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "osis", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreatePipelineEndpointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("osis", "OSIS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/2022-01-01/osis/createPipelineEndpoint";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"PipelineArn\":");
    try aws.json.writeValue(@TypeOf(input.pipeline_arn), input.pipeline_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"VpcOptions\":");
    try aws.json.writeValue(@TypeOf(input.vpc_options), input.vpc_options, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreatePipelineEndpointOutput {
    var result: CreatePipelineEndpointOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreatePipelineEndpointOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
