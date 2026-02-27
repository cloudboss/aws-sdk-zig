const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const S3Location = @import("s3_location.zig").S3Location;

pub const StartSimulationInput = struct {
    /// A value that you provide to ensure that repeated calls to this
    /// API operation using the same parameters complete only once. A `ClientToken`
    /// is also known as an
    /// *idempotency token*. A `ClientToken` expires after 24 hours.
    client_token: ?[]const u8 = null,

    /// The description of the simulation.
    description: ?[]const u8 = null,

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
    name: []const u8,

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
    role_arn: []const u8,

    /// The location of the simulation schema in Amazon Simple Storage Service
    /// (Amazon S3).
    /// For more information about Amazon S3, see the [
    /// *Amazon Simple Storage Service User Guide*
    /// ](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html).
    ///
    /// Provide a `SchemaS3Location` to start your simulation from a schema.
    ///
    /// If you provide a `SchemaS3Location` then you can't provide a
    /// `SnapshotS3Location`.
    schema_s3_location: ?S3Location = null,

    /// The location of the snapshot .zip file in Amazon Simple Storage Service
    /// (Amazon S3).
    /// For more information about Amazon S3, see the [
    /// *Amazon Simple Storage Service User Guide*
    /// ](https://docs.aws.amazon.com/AmazonS3/latest/userguide/Welcome.html).
    ///
    /// Provide a `SnapshotS3Location` to start your simulation from a snapshot.
    ///
    /// The Amazon S3 bucket must be in the same Amazon Web Services Region as the
    /// simulation.
    ///
    /// If you provide a `SnapshotS3Location` then you can't provide a
    /// `SchemaS3Location`.
    snapshot_s3_location: ?S3Location = null,

    /// A list of tags for the simulation. For more information about tags, see
    /// [Tagging Amazon Web Services
    /// resources](https://docs.aws.amazon.com/general/latest/gr/aws_tagging.html)
    /// in the
    /// *Amazon Web Services General Reference*.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .description = "Description",
        .maximum_duration = "MaximumDuration",
        .name = "Name",
        .role_arn = "RoleArn",
        .schema_s3_location = "SchemaS3Location",
        .snapshot_s3_location = "SnapshotS3Location",
        .tags = "Tags",
    };
};

pub const StartSimulationOutput = struct {
    /// The Amazon Resource Name (ARN) of the simulation. For more information about
    /// ARNs, see [Amazon Resource Names
    /// (ARNs)](https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html)
    /// in the *Amazon Web Services General Reference*.
    arn: ?[]const u8 = null,

    /// The time when the simulation was created, expressed as the
    /// number of seconds and milliseconds in UTC since the Unix epoch (0:0:0.000,
    /// January 1, 1970).
    creation_time: ?i64 = null,

    /// A universally unique identifier (UUID) for this simulation.
    execution_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .creation_time = "CreationTime",
        .execution_id = "ExecutionId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartSimulationInput, options: Options) !StartSimulationOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: StartSimulationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("simspaceweaver", "SimSpaceWeaver", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const path = "/startsimulation";

    var body_buf: std.ArrayList(u8) = .{};
    var has_prev = false;
    try body_buf.appendSlice(alloc, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.maximum_duration) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"MaximumDuration\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, alloc, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(alloc, ",");
    try body_buf.appendSlice(alloc, "\"RoleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, alloc, &body_buf);
    has_prev = true;
    if (input.schema_s3_location) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"SchemaS3Location\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.snapshot_s3_location) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"SnapshotS3Location\":");
        try aws.json.writeValue(@TypeOf(v), v, alloc, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(alloc, ",");
        try body_buf.appendSlice(alloc, "\"Tags\":");
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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !StartSimulationOutput {
    var result: StartSimulationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartSimulationOutput, body, alloc);
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
