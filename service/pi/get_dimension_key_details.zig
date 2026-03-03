const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const ServiceType = @import("service_type.zig").ServiceType;
const DimensionKeyDetail = @import("dimension_key_detail.zig").DimensionKeyDetail;

pub const GetDimensionKeyDetailsInput = struct {
    /// The name of the dimension group. Performance Insights searches the specified
    /// group for the dimension group ID. The following group name values are
    /// valid:
    ///
    /// * `db.execution_plan` (Amazon RDS and Aurora only)
    ///
    /// * `db.lock_snapshot` (Aurora only)
    ///
    /// * `db.query` (Amazon DocumentDB only)
    ///
    /// * `db.sql` (Amazon RDS and Aurora only)
    group: []const u8,

    /// The ID of the dimension group from which to retrieve dimension details. For
    /// dimension group `db.sql`, the group ID is
    /// `db.sql.id`. The following group ID values are valid:
    ///
    /// * `db.execution_plan.id` for dimension group `db.execution_plan` (Aurora and
    ///   RDS only)
    ///
    /// * `db.sql.id` for dimension group `db.sql` (Aurora and RDS only)
    ///
    /// * `db.query.id` for dimension group `db.query` (DocumentDB only)
    ///
    /// * For the dimension group `db.lock_snapshot`, the `GroupIdentifier` is the
    ///   epoch timestamp when Performance Insights captured the snapshot, in
    ///   seconds.
    /// You can retrieve this value with the `GetResourceMetrics` operation for a 1
    /// second period.
    group_identifier: []const u8,

    /// The ID for a data source from which to gather dimension data. This ID must
    /// be immutable and
    /// unique within an Amazon Web Services Region. When a DB instance is the data
    /// source, specify its
    /// `DbiResourceId` value. For example, specify `db-ABCDEFGHIJKLMNOPQRSTU1VW2X`.
    identifier: []const u8,

    /// A list of dimensions to retrieve the detail data for within the given
    /// dimension group. If you don't specify this parameter, Performance Insights
    /// returns
    /// all dimension data within the specified dimension group. Specify dimension
    /// names for the following dimension groups:
    ///
    /// * `db.execution_plan` - Specify the dimension name
    ///   `db.execution_plan.raw_plan` or the short dimension name `raw_plan`
    ///   (Amazon RDS and Aurora only)
    ///
    /// * `db.lock_snapshot` - Specify the dimension name
    ///   `db.lock_snapshot.lock_trees` or the short dimension name `lock_trees`.
    ///   (Aurora only)
    ///
    /// * `db.sql` - Specify either the full dimension name `db.sql.statement` or
    ///   the short dimension name
    /// `statement` (Aurora and RDS only).
    ///
    /// * `db.query` - Specify either the full dimension name `db.query.statement`
    ///   or the short dimension name
    /// `statement` (DocumentDB only).
    requested_dimensions: ?[]const []const u8 = null,

    /// The Amazon Web Services service for which Performance Insights returns data.
    /// The only valid value is `RDS`.
    service_type: ServiceType,

    pub const json_field_names = .{
        .group = "Group",
        .group_identifier = "GroupIdentifier",
        .identifier = "Identifier",
        .requested_dimensions = "RequestedDimensions",
        .service_type = "ServiceType",
    };
};

pub const GetDimensionKeyDetailsOutput = struct {
    /// The details for the requested dimensions.
    dimensions: ?[]const DimensionKeyDetail = null,

    pub const json_field_names = .{
        .dimensions = "Dimensions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDimensionKeyDetailsInput, options: CallOptions) !GetDimensionKeyDetailsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "pi");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDimensionKeyDetailsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pi", "PI", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "PerformanceInsightsv20180227.GetDimensionKeyDetails");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDimensionKeyDetailsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetDimensionKeyDetailsOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "InternalServiceError")) {
        return .{ .arena = arena, .kind = .{ .internal_service_error = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidArgumentException")) {
        return .{ .arena = arena, .kind = .{ .invalid_argument_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "NotAuthorizedException")) {
        return .{ .arena = arena, .kind = .{ .not_authorized_exception = .{
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
