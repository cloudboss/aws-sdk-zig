const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GiMinorVersionSummary = @import("gi_minor_version_summary.zig").GiMinorVersionSummary;

pub const ListGiMinorVersionsInput = struct {
    /// The Availability Zone to filter GI minor versions.
    availability_zone: ?[]const u8 = null,

    /// The Availability Zone ID to filter GI minor versions.
    availability_zone_id: ?[]const u8 = null,

    /// The Oracle Grid Infrastructure (GI) major version.
    gi_version: []const u8,

    /// The maximum number of items to return for this request. To get the next page
    /// of items, make another request with the token returned in the output.
    max_results: ?i32 = null,

    /// The token returned from a previous paginated request. Pagination continues
    /// from the end of the items returned by the previous request.
    next_token: ?[]const u8 = null,

    /// The shape family for the GI minor version.
    shape_family: ?[]const u8 = null,

    pub const json_field_names = .{
        .availability_zone = "availabilityZone",
        .availability_zone_id = "availabilityZoneId",
        .gi_version = "giVersion",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .shape_family = "shapeFamily",
    };
};

pub const ListGiMinorVersionsOutput = struct {
    /// The list of GI minor versions.
    gi_minor_versions: ?[]const GiMinorVersionSummary = null,

    /// The token to include in another request to get the next page of items. This
    /// value is `null` when there are no more items to return.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .gi_minor_versions = "giMinorVersions",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListGiMinorVersionsInput, options: CallOptions) !ListGiMinorVersionsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "odb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListGiMinorVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("odb", "odb", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Odb.ListGiMinorVersions");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListGiMinorVersionsOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(ListGiMinorVersionsOutput, body, allocator);
}
