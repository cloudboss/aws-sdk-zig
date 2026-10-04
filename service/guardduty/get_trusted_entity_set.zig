const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TrustedEntitySetFormat = @import("trusted_entity_set_format.zig").TrustedEntitySetFormat;
const TrustedEntitySetStatus = @import("trusted_entity_set_status.zig").TrustedEntitySetStatus;

pub const GetTrustedEntitySetInput = struct {
    /// The unique ID of the GuardDuty detector associated with this trusted entity
    /// set.
    detector_id: []const u8,

    /// The unique ID that helps GuardDuty identify the trusted entity set.
    trusted_entity_set_id: []const u8,

    pub const json_field_names = .{
        .detector_id = "DetectorId",
        .trusted_entity_set_id = "TrustedEntitySetId",
    };
};

pub const GetTrustedEntitySetOutput = struct {
    /// The timestamp when the associated trusted entity set was created.
    created_at: ?i64 = null,

    /// The error details when the status is shown as `ERROR`.
    error_details: ?[]const u8 = null,

    /// The Amazon Web Services account ID that owns the Amazon S3 bucket specified
    /// in the **location** parameter.
    expected_bucket_owner: ?[]const u8 = null,

    /// The format of the file that contains the trusted entity set.
    format: TrustedEntitySetFormat,

    /// The URI of the file that contains the trusted entity set.
    location: []const u8,

    /// The name of the threat entity set associated with the specified
    /// `trustedEntitySetId`.
    name: []const u8,

    /// The status of the associated trusted entity set.
    status: TrustedEntitySetStatus,

    /// The tags associated with trusted entity set resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp when the associated trusted entity set was updated.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .error_details = "ErrorDetails",
        .expected_bucket_owner = "ExpectedBucketOwner",
        .format = "Format",
        .location = "Location",
        .name = "Name",
        .status = "Status",
        .tags = "Tags",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetTrustedEntitySetInput, options: CallOptions) !GetTrustedEntitySetOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetTrustedEntitySetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("guardduty", "GuardDuty", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/detector/");
    try path_buf.appendSlice(allocator, input.detector_id);
    try path_buf.appendSlice(allocator, "/trustedentityset/");
    try path_buf.appendSlice(allocator, input.trusted_entity_set_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetTrustedEntitySetOutput {
    var result: GetTrustedEntitySetOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetTrustedEntitySetOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
