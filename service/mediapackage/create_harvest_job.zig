const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const S3Destination = @import("s3_destination.zig").S3Destination;
const Status = @import("status.zig").Status;

pub const CreateHarvestJobInput = struct {
    /// The end of the time-window which will be harvested
    end_time: []const u8,

    /// The ID of the HarvestJob. The ID must be unique within the region
    /// and it cannot be changed after the HarvestJob is submitted
    id: []const u8,

    /// The ID of the OriginEndpoint that the HarvestJob will harvest from.
    /// This cannot be changed after the HarvestJob is submitted.
    origin_endpoint_id: []const u8,

    s3_destination: S3Destination,

    /// The start of the time-window which will be harvested
    start_time: []const u8,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .id = "Id",
        .origin_endpoint_id = "OriginEndpointId",
        .s3_destination = "S3Destination",
        .start_time = "StartTime",
    };
};

pub const CreateHarvestJobOutput = struct {
    /// The Amazon Resource Name (ARN) assigned to the HarvestJob.
    arn: ?[]const u8 = null,

    /// The ID of the Channel that the HarvestJob will harvest from.
    channel_id: ?[]const u8 = null,

    /// The date and time the HarvestJob was submitted.
    created_at: ?[]const u8 = null,

    /// The end of the time-window which will be harvested.
    end_time: ?[]const u8 = null,

    /// The ID of the HarvestJob. The ID must be unique within the region
    /// and it cannot be changed after the HarvestJob is submitted.
    id: ?[]const u8 = null,

    /// The ID of the OriginEndpoint that the HarvestJob will harvest from.
    /// This cannot be changed after the HarvestJob is submitted.
    origin_endpoint_id: ?[]const u8 = null,

    s3_destination: ?S3Destination = null,

    /// The start of the time-window which will be harvested.
    start_time: ?[]const u8 = null,

    /// The current status of the HarvestJob. Consider setting up a CloudWatch Event
    /// to listen for
    /// HarvestJobs as they succeed or fail. In the event of failure, the CloudWatch
    /// Event will
    /// include an explanation of why the HarvestJob failed.
    status: ?Status = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .channel_id = "ChannelId",
        .created_at = "CreatedAt",
        .end_time = "EndTime",
        .id = "Id",
        .origin_endpoint_id = "OriginEndpointId",
        .s3_destination = "S3Destination",
        .start_time = "StartTime",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateHarvestJobInput, options: CallOptions) !CreateHarvestJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mediapackage", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateHarvestJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mediapackage", "MediaPackage", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/harvest_jobs";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EndTime\":");
    try aws.json.writeValue(@TypeOf(input.end_time), input.end_time, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Id\":");
    try aws.json.writeValue(@TypeOf(input.id), input.id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"OriginEndpointId\":");
    try aws.json.writeValue(@TypeOf(input.origin_endpoint_id), input.origin_endpoint_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"S3Destination\":");
    try aws.json.writeValue(@TypeOf(input.s3_destination), input.s3_destination, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"StartTime\":");
    try aws.json.writeValue(@TypeOf(input.start_time), input.start_time, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateHarvestJobOutput {
    const result: CreateHarvestJobOutput = try aws.json.parseJsonObject(
        CreateHarvestJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
