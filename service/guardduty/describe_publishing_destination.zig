const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DestinationProperties = @import("destination_properties.zig").DestinationProperties;
const DestinationType = @import("destination_type.zig").DestinationType;
const PublishingStatus = @import("publishing_status.zig").PublishingStatus;

pub const DescribePublishingDestinationInput = struct {
    /// The ID of the publishing destination to retrieve.
    destination_id: []const u8,

    /// The unique ID of the detector associated with the publishing destination to
    /// retrieve.
    ///
    /// To find the `detectorId` in the current Region, see the Settings page in the
    /// GuardDuty console, or run the
    /// [ListDetectors](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_ListDetectors.html) API.
    detector_id: []const u8,

    pub const json_field_names = .{
        .destination_id = "DestinationId",
        .detector_id = "DetectorId",
    };
};

pub const DescribePublishingDestinationOutput = struct {
    /// The ID of the publishing destination.
    destination_id: []const u8,

    /// A `DestinationProperties` object that includes the `DestinationArn` and
    /// `KmsKeyArn` of the publishing destination.
    destination_properties: ?DestinationProperties = null,

    /// The type of publishing destination. Currently, only Amazon S3 buckets are
    /// supported.
    destination_type: DestinationType,

    /// The time, in epoch millisecond format, at which GuardDuty was first unable
    /// to publish findings to the destination.
    publishing_failure_start_timestamp: i64,

    /// The status of the publishing destination.
    status: PublishingStatus,

    /// The tags of the publishing destination resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .destination_id = "DestinationId",
        .destination_properties = "DestinationProperties",
        .destination_type = "DestinationType",
        .publishing_failure_start_timestamp = "PublishingFailureStartTimestamp",
        .status = "Status",
        .tags = "Tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePublishingDestinationInput, options: CallOptions) !DescribePublishingDestinationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "guardduty", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePublishingDestinationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("guardduty", "GuardDuty", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/detector/");
    try path_buf.appendSlice(allocator, input.detector_id);
    try path_buf.appendSlice(allocator, "/publishingDestination/");
    try path_buf.appendSlice(allocator, input.destination_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePublishingDestinationOutput {
    const result: DescribePublishingDestinationOutput = try aws.json.parseJsonObject(
        DescribePublishingDestinationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
