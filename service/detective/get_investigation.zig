const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EntityType = @import("entity_type.zig").EntityType;
const Severity = @import("severity.zig").Severity;
const State = @import("state.zig").State;
const Status = @import("status.zig").Status;

pub const GetInvestigationInput = struct {
    /// The Amazon Resource Name (ARN) of the behavior graph.
    graph_arn: []const u8,

    /// The investigation ID of the investigation report.
    investigation_id: []const u8,

    pub const json_field_names = .{
        .graph_arn = "GraphArn",
        .investigation_id = "InvestigationId",
    };
};

pub const GetInvestigationOutput = struct {
    /// The creation time of the investigation report in UTC time stamp format.
    created_time: ?i64 = null,

    /// The unique Amazon Resource Name (ARN). Detective supports IAM user ARNs and
    /// IAM role ARNs.
    entity_arn: ?[]const u8 = null,

    /// Type of entity. For example, Amazon Web Services accounts, such as an IAM
    /// user and/or IAM role.
    entity_type: ?EntityType = null,

    /// The Amazon Resource Name (ARN) of the behavior graph.
    graph_arn: ?[]const u8 = null,

    /// The investigation ID of the investigation report.
    investigation_id: ?[]const u8 = null,

    /// The data and time when the investigation began. The value is an UTC ISO8601
    /// formatted
    /// string. For example, `2021-08-18T16:35:56.284Z`.
    scope_end_time: ?i64 = null,

    /// The start date and time used to set the scope time within which you want to
    /// generate the investigation report. The value is an UTC ISO8601 formatted
    /// string. For example, `2021-08-18T16:35:56.284Z`.
    scope_start_time: ?i64 = null,

    /// The severity assigned is based on the likelihood and impact of the
    /// indicators of
    /// compromise discovered in the investigation.
    severity: ?Severity = null,

    /// The current state of the investigation. An archived investigation indicates
    /// that you
    /// have completed reviewing the investigation.
    state: ?State = null,

    /// The status based on the completion status of the investigation.
    status: ?Status = null,

    pub const json_field_names = .{
        .created_time = "CreatedTime",
        .entity_arn = "EntityArn",
        .entity_type = "EntityType",
        .graph_arn = "GraphArn",
        .investigation_id = "InvestigationId",
        .scope_end_time = "ScopeEndTime",
        .scope_start_time = "ScopeStartTime",
        .severity = "Severity",
        .state = "State",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetInvestigationInput, options: CallOptions) !GetInvestigationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "detective", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetInvestigationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.detective", "Detective", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/investigations/getInvestigation";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"GraphArn\":");
    try aws.json.writeValue(@TypeOf(input.graph_arn), input.graph_arn, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"InvestigationId\":");
    try aws.json.writeValue(@TypeOf(input.investigation_id), input.investigation_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetInvestigationOutput {
    const result: GetInvestigationOutput = try aws.json.parseJsonObject(
        GetInvestigationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
