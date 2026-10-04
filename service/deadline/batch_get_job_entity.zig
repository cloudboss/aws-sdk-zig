const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobEntityIdentifiersUnion = @import("job_entity_identifiers_union.zig").JobEntityIdentifiersUnion;
const JobEntity = @import("job_entity.zig").JobEntity;
const GetJobEntityError = @import("get_job_entity_error.zig").GetJobEntityError;

pub const BatchGetJobEntityInput = struct {
    /// The farm ID of the worker that's fetching job details. The worker must have
    /// an assignment on a job to fetch job details.
    farm_id: []const u8,

    /// The fleet ID of the worker that's fetching job details. The worker must have
    /// an assignment on a job to fetch job details.
    fleet_id: []const u8,

    /// The job identifiers to include within the job entity batch details.
    identifiers: []const JobEntityIdentifiersUnion,

    /// The worker ID of the worker containing the job details to get.
    worker_id: []const u8,

    pub const json_field_names = .{
        .farm_id = "farmId",
        .fleet_id = "fleetId",
        .identifiers = "identifiers",
        .worker_id = "workerId",
    };
};

pub const BatchGetJobEntityOutput = struct {
    /// A list of the job entities, or details, in the batch.
    entities: ?[]const JobEntity = null,

    /// A list of errors from the job error logs for the batch.
    errors: ?[]const GetJobEntityError = null,

    pub const json_field_names = .{
        .entities = "entities",
        .errors = "errors",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetJobEntityInput, options: CallOptions) !BatchGetJobEntityOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "deadline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetJobEntityInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("deadline", "deadline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2023-10-12/farms/");
    try path_buf.appendSlice(allocator, input.farm_id);
    try path_buf.appendSlice(allocator, "/fleets/");
    try path_buf.appendSlice(allocator, input.fleet_id);
    try path_buf.appendSlice(allocator, "/workers/");
    try path_buf.appendSlice(allocator, input.worker_id);
    try path_buf.appendSlice(allocator, "/batchGetJobEntity");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"identifiers\":");
    try aws.json.writeValue(@TypeOf(input.identifiers), input.identifiers, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetJobEntityOutput {
    const result: BatchGetJobEntityOutput = try aws.json.parseJsonObject(
        BatchGetJobEntityOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
