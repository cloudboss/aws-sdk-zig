const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const EvaluationFormValidationFinding = @import("evaluation_form_validation_finding.zig").EvaluationFormValidationFinding;
const EvaluationFormValidationStatus = @import("evaluation_form_validation_status.zig").EvaluationFormValidationStatus;

pub const GetEvaluationFormValidationInput = struct {
    /// The unique identifier for the evaluation form.
    evaluation_form_id: []const u8,

    /// The version of the evaluation form to retrieve validation results for.
    evaluation_form_version: ?i32 = null,

    /// The identifier of the Connect Customer instance. You can [find the instance
    /// ID](https://docs.aws.amazon.com/connect/latest/adminguide/find-instance-arn.html) in the Amazon Resource Name (ARN) of the instance.
    instance_id: []const u8,

    pub const json_field_names = .{
        .evaluation_form_id = "EvaluationFormId",
        .evaluation_form_version = "EvaluationFormVersion",
        .instance_id = "InstanceId",
    };
};

pub const GetEvaluationFormValidationOutput = struct {
    /// The unique identifier for the evaluation form.
    evaluation_form_id: []const u8,

    /// A version of the evaluation form.
    evaluation_form_version: ?i32 = null,

    /// The reason the validation failed. This field is populated only when the
    /// status is
    /// `FAILED`.
    failure_reason: ?[]const u8 = null,

    /// A list of findings from the validation process. Each finding identifies a
    /// structural issue or quality
    /// improvement for the evaluation form, and may include a suggested fix. This
    /// field is populated when the status is
    /// `COMPLETED`.
    findings: ?[]const EvaluationFormValidationFinding = null,

    /// The timestamp when the validation process was started.
    started_time: i64,

    /// The current status of the validation process. Valid values: `IN_PROGRESS`,
    /// `COMPLETED`, `FAILED`.
    status: EvaluationFormValidationStatus,

    pub const json_field_names = .{
        .evaluation_form_id = "EvaluationFormId",
        .evaluation_form_version = "EvaluationFormVersion",
        .failure_reason = "FailureReason",
        .findings = "Findings",
        .started_time = "StartedTime",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetEvaluationFormValidationInput, options: CallOptions) !GetEvaluationFormValidationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "connect", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetEvaluationFormValidationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("connect", "Connect", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/evaluation-forms/");
    try path_buf.appendSlice(allocator, input.instance_id);
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.evaluation_form_id);
    try path_buf.appendSlice(allocator, "/validation-results");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.evaluation_form_version) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "version=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetEvaluationFormValidationOutput {
    const result: GetEvaluationFormValidationOutput = try aws.json.parseJsonObject(
        GetEvaluationFormValidationOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
