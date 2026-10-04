const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Trail = @import("trail.zig").Trail;

pub const DescribeTrailsInput = struct {
    /// Specifies whether to include shadow trails in the response. A shadow trail
    /// is the
    /// replication in a Region of a trail that was created in a different Region,
    /// or in the case
    /// of an organization trail, the replication of an organization trail in member
    /// accounts. If
    /// you do not include shadow trails, organization trails in a member account
    /// and Region
    /// replication trails will not be returned. The default is true.
    include_shadow_trails: ?bool = null,

    /// Specifies a list of trail names, trail ARNs, or both, of the trails to
    /// describe. The
    /// format of a trail ARN is:
    ///
    /// `arn:aws:cloudtrail:us-east-2:123456789012:trail/MyTrail`
    ///
    /// If an empty list is specified, information for the trail in the current
    /// Region is
    /// returned.
    ///
    /// * If an empty list is specified and `IncludeShadowTrails` is false, then
    /// information for all trails in the current Region is returned.
    ///
    /// * If an empty list is specified and IncludeShadowTrails is null or true,
    ///   then
    /// information for all trails in the current Region and any associated shadow
    /// trails in
    /// other Regions is returned.
    ///
    /// If one or more trail names are specified, information is returned only if
    /// the names
    /// match the names of trails belonging only to the current Region and current
    /// account. To
    /// return information about a trail in another Region, you must specify its
    /// trail
    /// ARN.
    trail_name_list: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .include_shadow_trails = "includeShadowTrails",
        .trail_name_list = "trailNameList",
    };
};

pub const DescribeTrailsOutput = struct {
    /// The list of trail objects. Trail objects with string values are only
    /// returned if values
    /// for the objects exist in a trail's configuration. For example,
    /// `SNSTopicName`
    /// and `SNSTopicARN` are only returned in results if a trail is configured to
    /// send
    /// SNS notifications. Similarly, `KMSKeyId` only appears in results if a
    /// trail's
    /// log files are encrypted with KMS
    /// customer managed keys.
    trail_list: ?[]const Trail = null,

    pub const json_field_names = .{
        .trail_list = "trailList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeTrailsInput, options: CallOptions) !DescribeTrailsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudtrail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeTrailsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudtrail", "CloudTrail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "CloudTrail_20131101.DescribeTrails");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeTrailsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(DescribeTrailsOutput, body, allocator);
}
