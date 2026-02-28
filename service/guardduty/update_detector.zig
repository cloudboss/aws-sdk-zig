const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DataSourceConfigurations = @import("data_source_configurations.zig").DataSourceConfigurations;
const DetectorFeatureConfiguration = @import("detector_feature_configuration.zig").DetectorFeatureConfiguration;
const FindingPublishingFrequency = @import("finding_publishing_frequency.zig").FindingPublishingFrequency;

pub const UpdateDetectorInput = struct {
    /// Describes which data sources will be updated.
    ///
    /// There might be regional differences because some data sources might not be
    /// available in all the Amazon Web Services Regions where GuardDuty is
    /// presently supported. For more
    /// information, see [Regions and
    /// endpoints](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_regions.html).
    data_sources: ?DataSourceConfigurations = null,

    /// The unique ID of the detector to update.
    ///
    /// To find the `detectorId` in the current Region, see the
    /// Settings page in the GuardDuty console, or run the
    /// [ListDetectors](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_ListDetectors.html) API.
    detector_id: []const u8,

    /// Specifies whether the detector is enabled or not enabled.
    enable: ?bool = null,

    /// Provides the features that will be updated for the detector.
    features: ?[]const DetectorFeatureConfiguration = null,

    /// An enum value that specifies how frequently findings are exported, such as
    /// to CloudWatch
    /// Events.
    finding_publishing_frequency: ?FindingPublishingFrequency = null,

    pub const json_field_names = .{
        .data_sources = "DataSources",
        .detector_id = "DetectorId",
        .enable = "Enable",
        .features = "Features",
        .finding_publishing_frequency = "FindingPublishingFrequency",
    };
};

pub const UpdateDetectorOutput = struct {
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateDetectorInput, options: Options) !UpdateDetectorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "guardduty");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: UpdateDetectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("guardduty", "GuardDuty", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(alloc, "/detector/");
    try path_buf.appendSlice(alloc, input.detector_id);
    const path = try path_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.data_sources) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"DataSources\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.enable) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Enable\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.features) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Features\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.finding_publishing_frequency) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"FindingPublishingFrequency\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !UpdateDetectorOutput {
    _ = alloc;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateDetectorOutput = .{};

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
    if (std.mem.eql(u8, error_code, "BadRequestException")) {
        return .{ .arena = arena, .kind = .{ .bad_request_exception = .{
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
    if (std.mem.eql(u8, error_code, "InternalServerErrorException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_error_exception = .{
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

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
