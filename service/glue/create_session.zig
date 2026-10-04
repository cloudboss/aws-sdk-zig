const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SessionCommand = @import("session_command.zig").SessionCommand;
const ConnectionsList = @import("connections_list.zig").ConnectionsList;
const SessionType = @import("session_type.zig").SessionType;
const WorkerType = @import("worker_type.zig").WorkerType;
const Session = @import("session.zig").Session;

pub const CreateSessionInput = struct {
    /// The `SessionCommand` that runs the job.
    command: SessionCommand,

    /// The number of connections to use for the session.
    connections: ?ConnectionsList = null,

    /// A map array of key-value pairs. Max is 75 pairs.
    default_arguments: ?[]const aws.map.StringMapEntry = null,

    /// The description of the session.
    description: ?[]const u8 = null,

    /// The Glue version determines the versions of Apache Spark and Python that
    /// Glue supports.
    /// The GlueVersion must be greater than 2.0.
    glue_version: ?[]const u8 = null,

    /// The ID of the session request.
    id: []const u8,

    /// The number of minutes when idle before session times out. Default for
    /// Spark ETL jobs is value of Timeout. Consult the documentation
    /// for other job types.
    idle_timeout: ?i32 = null,

    /// The number of Glue data processing units (DPUs) that can be allocated when
    /// the job runs.
    /// A DPU is a relative measure of processing power that consists of 4 vCPUs of
    /// compute capacity and 16 GB memory.
    max_capacity: ?f64 = null,

    /// The number of workers of a defined `WorkerType` to use for the session.
    number_of_workers: ?i32 = null,

    /// The origin of the request.
    request_origin: ?[]const u8 = null,

    /// The IAM Role ARN
    role: []const u8,

    /// The name of the SecurityConfiguration structure to be used with the session
    security_configuration: ?[]const u8 = null,

    /// The type of session to create.
    session_type: ?SessionType = null,

    /// The map of key value pairs (tags) belonging to the session.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The number of minutes before session times out. Default for Spark ETL
    /// jobs is 48 hours (2880 minutes).
    /// Consult the documentation for other job types.
    timeout: ?i32 = null,

    /// The type of predefined worker that is allocated when a job runs. Accepts a
    /// value of
    /// G.1X, G.2X, G.4X, or G.8X for Spark jobs. Accepts the value Z.2X for Ray
    /// notebooks.
    ///
    /// * For the `G.1X` worker type, each worker maps to 1 DPU (4 vCPUs, 16 GB of
    ///   memory) with 94GB disk, and provides 1 executor per worker. We recommend
    ///   this worker type for workloads such as data transforms, joins, and
    ///   queries, to offers a scalable and cost effective way to run most jobs.
    ///
    /// * For the `G.2X` worker type, each worker maps to 2 DPU (8 vCPUs, 32 GB of
    ///   memory) with 138GB disk, and provides 1 executor per worker. We recommend
    ///   this worker type for workloads such as data transforms, joins, and
    ///   queries, to offers a scalable and cost effective way to run most jobs.
    ///
    /// * For the `G.4X` worker type, each worker maps to 4 DPU (16 vCPUs, 64 GB of
    ///   memory) with 256GB disk, and provides 1 executor per worker. We recommend
    ///   this worker type for jobs whose workloads contain your most demanding
    ///   transforms, aggregations, joins, and queries. This worker type is
    ///   available only for Glue version 3.0 or later Spark ETL jobs in the
    ///   following Amazon Web Services Regions: US East (Ohio), US East (N.
    ///   Virginia), US West (Oregon), Asia Pacific (Singapore), Asia Pacific
    ///   (Sydney), Asia Pacific (Tokyo), Canada (Central), Europe (Frankfurt),
    ///   Europe (Ireland), and Europe (Stockholm).
    ///
    /// * For the `G.8X` worker type, each worker maps to 8 DPU (32 vCPUs, 128 GB of
    ///   memory) with 512GB disk, and provides 1 executor per worker. We recommend
    ///   this worker type for jobs whose workloads contain your most demanding
    ///   transforms, aggregations, joins, and queries. This worker type is
    ///   available only for Glue version 3.0 or later Spark ETL jobs, in the same
    ///   Amazon Web Services Regions as supported for the `G.4X` worker type.
    ///
    /// * For the `Z.2X` worker type, each worker maps to 2 M-DPU (8vCPUs, 64 GB of
    ///   memory) with 128 GB disk, and provides up to 8 Ray workers based on the
    ///   autoscaler.
    worker_type: ?WorkerType = null,

    pub const json_field_names = .{
        .command = "Command",
        .connections = "Connections",
        .default_arguments = "DefaultArguments",
        .description = "Description",
        .glue_version = "GlueVersion",
        .id = "Id",
        .idle_timeout = "IdleTimeout",
        .max_capacity = "MaxCapacity",
        .number_of_workers = "NumberOfWorkers",
        .request_origin = "RequestOrigin",
        .role = "Role",
        .security_configuration = "SecurityConfiguration",
        .session_type = "SessionType",
        .tags = "Tags",
        .timeout = "Timeout",
        .worker_type = "WorkerType",
    };
};

pub const CreateSessionOutput = struct {
    /// Returns the session object in the response.
    session: ?Session = null,

    pub const json_field_names = .{
        .session = "Session",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSessionInput, options: CallOptions) !CreateSessionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSessionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.CreateSession");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSessionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateSessionOutput, body, allocator);
}
