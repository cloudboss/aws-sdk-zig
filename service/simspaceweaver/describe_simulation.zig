const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const LiveSimulationState = @import("live_simulation_state.zig").LiveSimulationState;
const LoggingConfiguration = @import("logging_configuration.zig").LoggingConfiguration;
const S3Location = @import("s3_location.zig").S3Location;
const SimulationStatus = @import("simulation_status.zig").SimulationStatus;
const SimulationTargetStatus = @import("simulation_target_status.zig").SimulationTargetStatus;

pub const DescribeSimulationInput = struct {
    /// The name of the simulation.
    simulation: []const u8,

    pub const json_field_names = .{
        .simulation = "Simulation",
    };
};

pub const DescribeSimulationOutput = struct {
    /// The Amazon Resource Name (ARN) of the simulation. For more information about
    /// ARNs, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html)
    /// in the *Amazon Web Services General Reference*.
    arn: ?[]const u8 = null,

    /// The time when the simulation was created, expressed as the
    /// number of seconds and milliseconds in UTC since the Unix epoch (0:0:0.000,
    /// January 1, 1970).
    creation_time: ?i64 = null,

    /// The description of the simulation.
    description: ?[]const u8 = null,

    /// A universally unique identifier (UUID) for this simulation.
    execution_id: ?[]const u8 = null,

    /// A collection of additional state information, such as
    /// domain and clock configuration.
    live_simulation_state: ?LiveSimulationState = null,

    /// Settings that control how SimSpace Weaver handles your simulation log data.
    logging_configuration: ?LoggingConfiguration = null,

    /// The maximum running time of the simulation,
    /// specified as a number of minutes (m or M), hours (h or H), or days (d or D).
    /// The simulation
    /// stops when it reaches this limit. The maximum value is `14D`, or its
    /// equivalent in the
    /// other units. The default value is `14D`. A value equivalent to `0` makes the
    /// simulation immediately transition to `Stopping` as soon as it reaches
    /// `Started`.
    maximum_duration: ?[]const u8 = null,

    /// The name of the simulation.
    name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Identity and Access Management (IAM)
    /// role
    /// that the simulation assumes to perform actions. For more information about
    /// ARNs, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html)
    /// in the *Amazon Web Services General Reference*. For more information about
    /// IAM roles,
    /// see [IAM
    /// roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles.html) in
    /// the
    /// *Identity and Access Management User Guide*.
    role_arn: ?[]const u8 = null,

    /// An error message that SimSpace Weaver returns only if there is a problem
    /// with the simulation
    /// schema.
    schema_error: ?[]const u8 = null,

    /// The location of the simulation schema in Amazon Simple Storage Service
    /// (Amazon S3).
    /// For more information about Amazon S3, see the [
    /// *Amazon Simple Storage Service User Guide*
    /// ](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html).
    schema_s3_location: ?S3Location = null,

    snapshot_s3_location: ?S3Location = null,

    /// An error message that SimSpace Weaver returns only if a problem occurs when
    /// the simulation is in the `STARTING` state.
    start_error: ?[]const u8 = null,

    /// The current lifecycle state of the simulation.
    status: ?SimulationStatus = null,

    /// The desired lifecycle state of the simulation.
    target_status: ?SimulationTargetStatus = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .description = "Description",
        .execution_id = "ExecutionId",
        .live_simulation_state = "LiveSimulationState",
        .logging_configuration = "LoggingConfiguration",
        .maximum_duration = "MaximumDuration",
        .name = "Name",
        .role_arn = "RoleArn",
        .schema_error = "SchemaError",
        .schema_s3_location = "SchemaS3Location",
        .snapshot_s3_location = "SnapshotS3Location",
        .start_error = "StartError",
        .status = "Status",
        .target_status = "TargetStatus",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSimulationInput, options: Options) !DescribeSimulationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "simspaceweaver");

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

fn serializeRequest(alloc: std.mem.Allocator, input: DescribeSimulationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("simspaceweaver", "SimSpaceWeaver", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/describesimulation";

    var query_buf: std.ArrayList(u8) = .{};
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(alloc, "&");
    try query_buf.appendSlice(alloc, "simulation=");
    try aws.url.appendUrlEncoded(alloc, &query_buf, input.simulation);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(alloc);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(host);
    request.method = .GET;
    request.path = path;
    request.tls = tls;
    request.port = port;
    request.body = body;
    request.query = query;
    try request.headers.put(alloc, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !DescribeSimulationOutput {
    var result: DescribeSimulationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeSimulationOutput, body, alloc);
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
    if (std.mem.eql(u8, error_code, "ServiceQuotaExceededException")) {
        return .{ .arena = arena, .kind = .{ .service_quota_exceeded_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "TooManyTagsException")) {
        return .{ .arena = arena, .kind = .{ .too_many_tags_exception = .{
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
