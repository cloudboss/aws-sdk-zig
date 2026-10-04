const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const AssociateStreamForSegmentsInput = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Kinesis data stream to deliver
    /// segment membership events to.
    /// For example, `arn:aws:kinesis:region:account-id:stream/stream-name`.
    destination_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the IAM role that allows Customer Profiles
    /// service principal to assume the role for
    /// conducting AWS Key Management Service (KMS) and Amazon Kinesis operations.
    /// The role must grant the following
    /// Amazon Kinesis permissions to deliver segment membership events to the
    /// stream:
    ///
    /// * `kinesis:PutRecord`
    ///
    /// * `kinesis:PutRecords`
    ///
    /// * `kinesis:DescribeStream`
    destination_role_arn: []const u8,

    /// The unique name of the domain.
    domain_name: []const u8,

    pub const json_field_names = .{
        .destination_arn = "DestinationArn",
        .destination_role_arn = "DestinationRoleArn",
        .domain_name = "DomainName",
    };
};

pub const AssociateStreamForSegmentsOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: AssociateStreamForSegmentsInput, options: CallOptions) !AssociateStreamForSegmentsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "profile", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: AssociateStreamForSegmentsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/segment-streams");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DestinationArn\":");
    try aws.json.writeValue(@TypeOf(input.destination_arn), input.destination_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"DestinationRoleArn\":");
    try aws.json.writeValue(@TypeOf(input.destination_role_arn), input.destination_role_arn, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !AssociateStreamForSegmentsOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: AssociateStreamForSegmentsOutput = .{};

    return result;
}
