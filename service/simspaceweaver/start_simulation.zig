const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartSimulationInput, options: CallOptions) !StartSimulationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "simspaceweaver", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartSimulationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("simspaceweaver", "SimSpaceWeaver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/startsimulation";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.maximum_duration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaximumDuration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RoleArn\":");
    try aws.json.writeValue(@TypeOf(input.role_arn), input.role_arn, allocator, &body_buf);
    has_prev = true;
    if (input.schema_s3_location) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SchemaS3Location\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.snapshot_s3_location) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"SnapshotS3Location\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartSimulationOutput {
    var result: StartSimulationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(StartSimulationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
