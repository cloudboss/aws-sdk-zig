const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const AutoshiftInResource = @import("autoshift_in_resource.zig").AutoshiftInResource;
const PracticeRunConfiguration = @import("practice_run_configuration.zig").PracticeRunConfiguration;
const ZonalAutoshiftStatus = @import("zonal_autoshift_status.zig").ZonalAutoshiftStatus;
const ZonalShiftInResource = @import("zonal_shift_in_resource.zig").ZonalShiftInResource;

pub const GetManagedResourceInput = struct {
    /// The identifier for the resource that Amazon Web Services shifts traffic for.
    /// The identifier is the Amazon Resource Name (ARN) for the resource.
    ///
    /// Amazon Application Recovery Controller currently supports enabling the
    /// following resources for zonal shift and zonal autoshift:
    ///
    /// * [Amazon EC2 Auto Scaling
    ///   groups](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-shift.resource-types.ec2-auto-scaling-groups.html)
    /// * [Amazon Elastic Kubernetes
    ///   Service](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-shift.resource-types.eks.html)
    /// * [Application Load
    ///   Balancer](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-shift.resource-types.app-load-balancers.html)
    /// * [Network Load
    ///   Balancer](https://docs.aws.amazon.com/r53recovery/latest/dg/arc-zonal-shift.resource-types.network-load-balancers.html)
    resource_identifier: []const u8,

    pub const json_field_names = .{
        .resource_identifier = "resourceIdentifier",
    };
};

pub const GetManagedResourceOutput = struct {
    /// A collection of key-value pairs that indicate whether resources are active
    /// in Availability Zones or not. The key name is the Availability Zone where
    /// the resource is deployed. The value is 1 or 0.
    applied_weights: ?[]const aws.map.MapEntry(f32) = null,

    /// The Amazon Resource Name (ARN) for the resource.
    arn: ?[]const u8 = null,

    /// An array of the autoshifts that are active for the resource.
    autoshifts: ?[]const AutoshiftInResource = null,

    /// The name of the resource.
    name: ?[]const u8 = null,

    /// The practice run configuration for zonal autoshift that's associated with
    /// the resource.
    practice_run_configuration: ?PracticeRunConfiguration = null,

    /// The status for zonal autoshift for a resource. When the autoshift status is
    /// `ENABLED`, Amazon Web Services shifts traffic for a resource away from an
    /// Availability Zone, on your behalf, when Amazon Web Services determines that
    /// there's an issue in the Availability Zone that could potentially affect
    /// customers.
    zonal_autoshift_status: ?ZonalAutoshiftStatus = null,

    /// The zonal shifts that are currently active for a resource.
    zonal_shifts: ?[]const ZonalShiftInResource = null,

    pub const json_field_names = .{
        .applied_weights = "appliedWeights",
        .arn = "arn",
        .autoshifts = "autoshifts",
        .name = "name",
        .practice_run_configuration = "practiceRunConfiguration",
        .zonal_autoshift_status = "zonalAutoshiftStatus",
        .zonal_shifts = "zonalShifts",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetManagedResourceInput, options: CallOptions) !GetManagedResourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "percdataplane");

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetManagedResourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("arc-zonal-shift", "ARC Zonal Shift", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var path_buf: std.ArrayList(u8) = .{};
    try path_buf.appendSlice(allocator, "/managedresources/");
    try path_buf.appendSlice(allocator, input.resource_identifier);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetManagedResourceOutput {
    var result: GetManagedResourceOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetManagedResourceOutput, body, allocator);
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
    if (std.mem.eql(u8, error_code, "InternalServerException")) {
        return .{ .arena = arena, .kind = .{ .internal_server_exception = .{
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
