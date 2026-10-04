const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AssociatedSegment = @import("associated_segment.zig").AssociatedSegment;
const EventSubscriptionState = @import("event_subscription_state.zig").EventSubscriptionState;

pub const GetStreamForSegmentsInput = struct {
    /// The unique name of the domain.
    domain_name: []const u8,

    pub const json_field_names = .{
        .domain_name = "DomainName",
    };
};

pub const GetStreamForSegmentsOutput = struct {
    /// The timestamp of when the stream was associated.
    associated_at: ?i64 = null,

    /// A list of segments currently associated with the stream and their
    /// subscription status.
    associated_segments: ?[]const AssociatedSegment = null,

    /// The Amazon Resource Name (ARN) of the Amazon Kinesis data stream receiving
    /// segment membership events.
    destination_arn: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM role used for Amazon Kinesis and
    /// AWS Key Management Service (KMS) operations.
    destination_role_arn: ?[]const u8 = null,

    /// The timestamp of when the stream was disassociated.
    disassociated_at: ?i64 = null,

    /// The unique name of the domain.
    domain_name: ?[]const u8 = null,

    /// The reason why the stream is in an unhealthy state, if applicable.
    failure_reason: ?[]const u8 = null,

    /// The operational state of the destination stream. The following are valid
    /// values:
    ///
    /// * **RUNNING**: The stream is associated and healthy.
    /// Segment membership events are being published.
    ///
    /// * **UNHEALTHY**: The stream is associated but events
    /// cannot currently be published. See `FailureReason` for details.
    ///
    /// * **STOPPED**: The stream is no longer publishing
    /// segment membership events.
    state: ?EventSubscriptionState = null,

    pub const json_field_names = .{
        .associated_at = "AssociatedAt",
        .associated_segments = "AssociatedSegments",
        .destination_arn = "DestinationArn",
        .destination_role_arn = "DestinationRoleArn",
        .disassociated_at = "DisassociatedAt",
        .domain_name = "DomainName",
        .failure_reason = "FailureReason",
        .state = "State",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetStreamForSegmentsInput, options: CallOptions) !GetStreamForSegmentsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetStreamForSegmentsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("profile", "Customer Profiles", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domains/");
    try path_buf.appendSlice(allocator, input.domain_name);
    try path_buf.appendSlice(allocator, "/segment-streams");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetStreamForSegmentsOutput {
    const result: GetStreamForSegmentsOutput = try aws.json.parseJsonObject(
        GetStreamForSegmentsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
