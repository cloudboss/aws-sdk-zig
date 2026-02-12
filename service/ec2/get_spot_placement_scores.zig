const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const InstanceRequirementsWithMetadataRequest = @import("instance_requirements_with_metadata_request.zig").InstanceRequirementsWithMetadataRequest;
const TargetCapacityUnitType = @import("target_capacity_unit_type.zig").TargetCapacityUnitType;
const SpotPlacementScore = @import("spot_placement_score.zig").SpotPlacementScore;
const serde = @import("serde.zig");

/// Calculates the Spot placement score for a Region or Availability Zone based
/// on the
/// specified target capacity and compute requirements.
///
/// You can specify your compute requirements either by using
/// `InstanceRequirementsWithMetadata` and letting Amazon EC2 choose the optimal
/// instance types to fulfill your Spot request, or you can specify the instance
/// types by using
/// `InstanceTypes`.
///
/// For more information, see [Spot placement
/// score](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-placement-score.html) in
/// the *Amazon EC2 User Guide*.
pub const GetSpotPlacementScoresInput = struct {
    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The attributes for the instance types. When you specify instance attributes,
    /// Amazon EC2 will
    /// identify instance types with those attributes.
    ///
    /// If you specify `InstanceRequirementsWithMetadata`, you can't specify
    /// `InstanceTypes`.
    instance_requirements_with_metadata: ?InstanceRequirementsWithMetadataRequest = null,

    /// The instance types. We recommend that you specify at least three instance
    /// types. If you
    /// specify one or two instance types, or specify variations of a single
    /// instance type (for
    /// example, an `m3.xlarge` with and without instance storage), the returned
    /// placement score will always be low.
    ///
    /// If you specify `InstanceTypes`, you can't specify
    /// `InstanceRequirementsWithMetadata`.
    instance_types: ?[]const []const u8 = null,

    /// The maximum number of items to return for this request.
    /// To get the next page of items, make another request with the token returned
    /// in the output.
    /// For more information, see
    /// [Pagination](https://docs.aws.amazon.com/AWSEC2/latest/APIReference/Query-Requests.html#api-pagination).
    max_results: ?i32 = null,

    /// The token returned from a previous paginated request. Pagination continues
    /// from the end of the items returned by the previous request.
    next_token: ?[]const u8 = null,

    /// The Regions used to narrow down the list of Regions to be scored. Enter the
    /// Region code,
    /// for example, `us-east-1`.
    region_names: ?[]const []const u8 = null,

    /// Specify `true` so that the response returns a list of scored Availability
    /// Zones.
    /// Otherwise, the response returns a list of scored Regions.
    ///
    /// A list of scored Availability Zones is useful if you want to launch all of
    /// your Spot
    /// capacity into a single Availability Zone.
    single_availability_zone: ?bool = null,

    /// The target capacity.
    target_capacity: i32,

    /// The unit for the target capacity.
    target_capacity_unit_type: ?TargetCapacityUnitType = null,
};

pub const GetSpotPlacementScoresOutput = struct {
    /// The token to include in another request to get the next page of items. This
    /// value is `null` when there
    /// are no more items to return.
    next_token: ?[]const u8 = null,

    /// The Spot placement score for the top 10 Regions or Availability Zones,
    /// scored on a scale
    /// from 1 to 10. Each score  reflects how likely it is that each Region or
    /// Availability Zone
    /// will succeed at fulfilling the specified target capacity  *at the time of
    /// the Spot
    /// placement score request*. A score of `10` means that your Spot
    /// capacity request is highly likely to succeed in that Region or Availability
    /// Zone.
    ///
    /// If you request a Spot placement score for Regions, a high score assumes that
    /// your fleet
    /// request will be configured to use all Availability Zones and the
    /// `capacity-optimized` allocation strategy. If you request a Spot placement
    /// score for Availability Zones, a high score assumes that your fleet request
    /// will be
    /// configured to use a single Availability Zone and the `capacity-optimized`
    /// allocation strategy.
    ///
    /// Different  Regions or Availability Zones might return the same score.
    ///
    /// **Note:**
    ///
    /// The Spot placement score serves as a recommendation only. No score
    /// guarantees that your
    /// Spot request will be fully or partially fulfilled.
    spot_placement_scores: ?[]const SpotPlacementScore = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *GetSpotPlacementScoresOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: GetSpotPlacementScoresInput, options: Options) !GetSpotPlacementScoresOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GetSpotPlacementScoresInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=GetSpotPlacementScores&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.instance_types) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&InstanceTypes.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.max_results) |v| {
        try body_buf.appendSlice(alloc, "&MaxResults=");
        try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.next_token) |v| {
        try body_buf.appendSlice(alloc, "&NextToken=");
        try appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.region_names) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            var prefix_buf: [256]u8 = undefined;
            const field_prefix = std.fmt.bufPrint(&prefix_buf, "&RegionNames.member.{d}=", .{n}) catch continue;
            try body_buf.appendSlice(alloc, field_prefix);
            try appendUrlEncoded(alloc, &body_buf, item);
        }
    }
    if (input.single_availability_zone) |v| {
        try body_buf.appendSlice(alloc, "&SingleAvailabilityZone=");
        try appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    try body_buf.appendSlice(alloc, "&TargetCapacity=");
    try appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{input.target_capacity}) catch "");
    if (input.target_capacity_unit_type) |v| {
        try body_buf.appendSlice(alloc, "&TargetCapacityUnitType=");
        try appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetSpotPlacementScoresOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: GetSpotPlacementScoresOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "nextToken")) {
                    result.next_token = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "spotPlacementScoreSet")) {
                    result.spot_placement_scores = try serde.deserializeSpotPlacementScores(&reader, alloc, "item");
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = findElement(body, "Code") orelse "Unknown";
    const error_message = findElement(body, "Message") orelse "";
    const request_id = findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}

fn findElement(xml: []const u8, tag_name: []const u8) ?[]const u8 {
    var buf: [256]u8 = undefined;

    const open_tag = std.fmt.bufPrint(&buf, "<{s}>", .{tag_name}) catch return null;
    const start = std.mem.indexOf(u8, xml, open_tag) orelse return null;
    const content_start = start + open_tag.len;

    var close_buf: [256]u8 = undefined;
    const close_tag = std.fmt.bufPrint(&close_buf, "</{s}>", .{tag_name}) catch return null;
    const end = std.mem.indexOfPos(u8, xml, content_start, close_tag) orelse return null;

    return xml[content_start..end];
}

fn appendUrlEncoded(alloc: std.mem.Allocator, buf: *std.ArrayList(u8), value: []const u8) !void {
    for (value) |c| {
        switch (c) {
            'A'...'Z', 'a'...'z', '0'...'9', '-', '_', '.', '~' => try buf.append(alloc, c),
            ' ' => try buf.append(alloc, '+'),
            else => {
                const hex = "0123456789ABCDEF";
                try buf.append(alloc, '%');
                try buf.append(alloc, hex[c >> 4]);
                try buf.append(alloc, hex[c & 0x0F]);
            }
        }
    }
}

fn parseHost(endpoint: []const u8) []const u8 {
    // Strip scheme
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    // Strip port and path
    const end = std.mem.indexOfAny(u8, after_scheme, ":/") orelse after_scheme.len;
    return after_scheme[0..end];
}

fn parsePort(endpoint: []const u8) ?u16 {
    const after_scheme = if (std.mem.indexOf(u8, endpoint, "://")) |idx| endpoint[idx + 3 ..] else endpoint;
    const colon = std.mem.indexOfScalar(u8, after_scheme, ':') orelse return null;
    const port_end = std.mem.indexOfScalarPos(u8, after_scheme, colon + 1, '/') orelse after_scheme.len;
    return std.fmt.parseInt(u16, after_scheme[colon + 1 .. port_end], 10) catch null;
}
