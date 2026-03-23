const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;

pub const UpdateFindingAggregatorInput = struct {
    /// The ARN of the finding aggregator. To obtain the ARN, use
    /// `ListFindingAggregators`.
    finding_aggregator_arn: []const u8,

    /// Indicates whether to aggregate findings from all of the available Regions in
    /// the current partition. Also determines whether to automatically aggregate
    /// findings from new Regions as Security Hub supports them and you opt into
    /// them.
    ///
    /// The selected option also determines how to use the Regions provided in the
    /// Regions list.
    ///
    /// The options are as follows:
    ///
    /// * `ALL_REGIONS` - Aggregates findings from all of the Regions where Security
    ///   Hub is enabled. When you choose this option, Security Hub also
    ///   automatically aggregates findings from new Regions as Security Hub
    ///   supports them and you opt into them.
    ///
    /// * `ALL_REGIONS_EXCEPT_SPECIFIED` - Aggregates findings from all of the
    ///   Regions where Security Hub is enabled, except for the Regions listed in
    ///   the `Regions` parameter. When you choose this option, Security Hub also
    ///   automatically aggregates findings from new Regions as Security Hub
    ///   supports them and you opt into them.
    ///
    /// * `SPECIFIED_REGIONS` - Aggregates findings only from the Regions listed in
    ///   the `Regions` parameter. Security Hub does not automatically aggregate
    ///   findings from new Regions.
    ///
    /// * `NO_REGIONS` - Aggregates no data because no Regions are selected as
    ///   linked Regions.
    region_linking_mode: []const u8,

    /// If `RegionLinkingMode` is `ALL_REGIONS_EXCEPT_SPECIFIED`, then this is a
    /// space-separated list of Regions that don't replicate and send findings to
    /// the home Region.
    ///
    /// If `RegionLinkingMode` is `SPECIFIED_REGIONS`, then this is a
    /// space-separated list of Regions that do replicate and send findings to the
    /// home Region.
    ///
    /// An `InvalidInputException` error results if you populate this field while
    /// `RegionLinkingMode` is
    /// `NO_REGIONS`.
    regions: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .finding_aggregator_arn = "FindingAggregatorArn",
        .region_linking_mode = "RegionLinkingMode",
        .regions = "Regions",
    };
};

pub const UpdateFindingAggregatorOutput = struct {
    /// The home Region. Findings generated in linked Regions are replicated and
    /// sent to the home Region.
    finding_aggregation_region: ?[]const u8 = null,

    /// The ARN of the finding aggregator.
    finding_aggregator_arn: ?[]const u8 = null,

    /// Indicates whether to link all Regions, all Regions except for a list of
    /// excluded Regions, or a list of included Regions.
    region_linking_mode: ?[]const u8 = null,

    /// The list of excluded Regions or included Regions.
    regions: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .finding_aggregation_region = "FindingAggregationRegion",
        .finding_aggregator_arn = "FindingAggregatorArn",
        .region_linking_mode = "RegionLinkingMode",
        .regions = "Regions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateFindingAggregatorInput, options: CallOptions) !UpdateFindingAggregatorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "securityhub");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateFindingAggregatorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/findingAggregator/update";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"FindingAggregatorArn\":");
    try aws.json.writeValue(@TypeOf(input.finding_aggregator_arn), input.finding_aggregator_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RegionLinkingMode\":");
    try aws.json.writeValue(@TypeOf(input.region_linking_mode), input.region_linking_mode, allocator, &body_buf);
    has_prev = true;
    if (input.regions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Regions\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .PATCH;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateFindingAggregatorOutput {
    var result: UpdateFindingAggregatorOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateFindingAggregatorOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "AccessDeniedException")) {
        return .{ .arena = arena, .kind = .{ .access_denied_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalException")) {
        return .{ .arena = arena, .kind = .{ .internal_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidAccessException")) {
        return .{ .arena = arena, .kind = .{ .invalid_access_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidInputException")) {
        return .{ .arena = arena, .kind = .{ .invalid_input_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "LimitExceededException")) {
        return .{ .arena = arena, .kind = .{ .limit_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceConflictException")) {
        return .{ .arena = arena, .kind = .{ .resource_conflict_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceInUseException")) {
        return .{ .arena = arena, .kind = .{ .resource_in_use_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ResourceNotFoundException")) {
        return .{ .arena = arena, .kind = .{ .resource_not_found_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ThrottlingException")) {
        return .{ .arena = arena, .kind = .{ .throttling_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "ValidationException")) {
        return .{ .arena = arena, .kind = .{ .validation_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
