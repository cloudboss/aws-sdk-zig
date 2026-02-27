const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const Service = @import("service.zig").Service;

pub const GetServiceInput = struct {
    /// The end of the time period to retrieve information about. When used in a raw
    /// HTTP Query API, it is formatted as be epoch time in seconds. For example:
    /// `1698778057`
    ///
    /// Your requested start time will be rounded to the nearest hour.
    end_time: i64,

    /// Use this field to specify which service you want to retrieve information
    /// for. You must specify at least the `Type`, `Name`, and `Environment`
    /// attributes.
    ///
    /// This is a string-to-string map. It can include the following fields.
    ///
    /// * `Type` designates the type of object this is.
    /// * `ResourceType` specifies the type of the resource. This field is used only
    ///   when the value of the `Type` field is `Resource` or `AWS::Resource`.
    /// * `Name` specifies the name of the object. This is used only if the value of
    ///   the `Type` field is `Service`, `RemoteService`, or `AWS::Service`.
    /// * `Identifier` identifies the resource objects of this resource. This is
    ///   used only if the value of the `Type` field is `Resource` or
    ///   `AWS::Resource`.
    /// * `Environment` specifies the location where this object is hosted, or what
    ///   it belongs to.
    key_attributes: []const aws.map.StringMapEntry,

    /// The start of the time period to retrieve information about. When used in a
    /// raw HTTP Query API, it is formatted as be epoch time in seconds. For
    /// example: `1698778057`
    ///
    /// Your requested start time will be rounded to the nearest hour.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .key_attributes = "KeyAttributes",
        .start_time = "StartTime",
    };
};

pub const GetServiceOutput = struct {
    /// The end time of the data included in the response. In a raw HTTP Query API,
    /// it is formatted as be epoch time in seconds. For example: `1698778057`.
    ///
    /// This displays the time that Application Signals used for the request. It
    /// might not match your request exactly, because it was rounded to the nearest
    /// hour.
    end_time: i64,

    /// An array of string-to-string maps that each contain information about one
    /// log group associated with this service. Each string-to-string map includes
    /// the following fields:
    ///
    /// * `"Type": "AWS::Resource"`
    /// * `"ResourceType": "AWS::Logs::LogGroup"`
    /// * `"Identifier": "*name-of-log-group*"`
    log_group_references: ?[]const []const aws.map.StringMapEntry = null,

    /// A structure containing information about the service.
    service: ?Service = null,

    /// The start time of the data included in the response. In a raw HTTP Query
    /// API, it is formatted as be epoch time in seconds. For example: `1698778057`.
    ///
    /// This displays the time that Application Signals used for the request. It
    /// might not match your request exactly, because it was rounded to the nearest
    /// hour.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .log_group_references = "LogGroupReferences",
        .service = "Service",
        .start_time = "StartTime",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetServiceInput, options: Options) !GetServiceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "applicationsignals");

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

fn serializeRequest(alloc: std.mem.Allocator, input: GetServiceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("applicationsignals", "Application Signals", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/service";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "EndTime=");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{input.end_time}) catch "";
        try query_buf.appendSlice(alloc, num_str);
    }
    query_has_prev = true;
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "StartTime=");
    {
        const num_str = std.fmt.allocPrint(alloc, "{d}", .{input.start_time}) catch "";
        try query_buf.appendSlice(alloc, num_str);
    }
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(alloc);

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"KeyAttributes\":");
    try aws.json.writeValue(@TypeOf(input.key_attributes), input.key_attributes, alloc, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(alloc, "}");
    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GetServiceOutput {
    var result: GetServiceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetServiceOutput, body, alloc);
    }
    _ = status;
    _ = headers;

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
    if (std.mem.eql(u8, error_code, "ConflictException")) {
        return .{ .arena = arena, .kind = .{ .conflict_exception = .{
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
