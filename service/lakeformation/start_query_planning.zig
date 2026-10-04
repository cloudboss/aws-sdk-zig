const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const QueryPlanningContext = @import("query_planning_context.zig").QueryPlanningContext;

pub const StartQueryPlanningInput = struct {
    /// A structure containing information about the query plan.
    query_planning_context: QueryPlanningContext,

    /// A PartiQL query statement used as an input to the planner service.
    query_string: []const u8,

    pub const json_field_names = .{
        .query_planning_context = "QueryPlanningContext",
        .query_string = "QueryString",
    };
};

pub const StartQueryPlanningOutput = struct {
    /// The ID of the plan query operation can be used to fetch the actual work unit
    /// descriptors that are produced as the result of the operation. The ID is also
    /// used to get the query state and as an input to the `Execute` operation.
    query_id: []const u8,

    pub const json_field_names = .{
        .query_id = "QueryId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartQueryPlanningInput, options: CallOptions) !StartQueryPlanningOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lakeformation", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartQueryPlanningInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lakeformation", "LakeFormation", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/StartQueryPlanning";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"QueryPlanningContext\":");
    try aws.json.writeValue(@TypeOf(input.query_planning_context), input.query_planning_context, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"QueryString\":");
    try aws.json.writeValue(@TypeOf(input.query_string), input.query_string, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartQueryPlanningOutput {
    const result: StartQueryPlanningOutput = try aws.json.parseJsonObject(
        StartQueryPlanningOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
