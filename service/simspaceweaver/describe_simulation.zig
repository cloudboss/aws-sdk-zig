const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeSimulationInput, options: CallOptions) !DescribeSimulationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeSimulationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("simspaceweaver", "SimSpaceWeaver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/describesimulation";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (query_has_prev) try query_buf.appendSlice(allocator, "&");
    try query_buf.appendSlice(allocator, "simulation=");
    try aws.url.appendUrlEncoded(allocator, &query_buf, input.simulation);
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeSimulationOutput {
    var result: DescribeSimulationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(DescribeSimulationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
