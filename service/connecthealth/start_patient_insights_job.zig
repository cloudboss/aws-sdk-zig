const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PatientInsightsEncounterContext = @import("patient_insights_encounter_context.zig").PatientInsightsEncounterContext;
const InputDataConfig = @import("input_data_config.zig").InputDataConfig;
const InsightsContext = @import("insights_context.zig").InsightsContext;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;
const PatientInsightsPatientContext = @import("patient_insights_patient_context.zig").PatientInsightsPatientContext;
const UserContext = @import("user_context.zig").UserContext;

pub const StartPatientInsightsJobInput = struct {
    /// Unique, case-sensitive identifier that you provide to ensure the idempotency
    /// of the request.
    client_token: ?[]const u8 = null,

    domain_id: []const u8,

    encounter_context: PatientInsightsEncounterContext,

    input_data_config: InputDataConfig,

    insights_context: InsightsContext,

    output_data_config: OutputDataConfig,

    patient_context: PatientInsightsPatientContext,

    user_context: UserContext,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .domain_id = "domainId",
        .encounter_context = "encounterContext",
        .input_data_config = "inputDataConfig",
        .insights_context = "insightsContext",
        .output_data_config = "outputDataConfig",
        .patient_context = "patientContext",
        .user_context = "userContext",
    };
};

pub const StartPatientInsightsJobOutput = struct {
    /// Date and time the patient insights job was submitted.
    creation_time: ?i64 = null,

    job_arn: []const u8,

    job_id: []const u8,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .job_arn = "jobArn",
        .job_id = "jobId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartPatientInsightsJobInput, options: CallOptions) !StartPatientInsightsJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "health-agent", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartPatientInsightsJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("health-agent", "ConnectHealth", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domain/");
    try path_buf.appendSlice(allocator, input.domain_id);
    try path_buf.appendSlice(allocator, "/patient-insights-job");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"encounterContext\":");
    try aws.json.writeValue(@TypeOf(input.encounter_context), input.encounter_context, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"inputDataConfig\":");
    try aws.json.writeValue(@TypeOf(input.input_data_config), input.input_data_config, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"insightsContext\":");
    try aws.json.writeValue(@TypeOf(input.insights_context), input.insights_context, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"outputDataConfig\":");
    try aws.json.writeValue(@TypeOf(input.output_data_config), input.output_data_config, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"patientContext\":");
    try aws.json.writeValue(@TypeOf(input.patient_context), input.patient_context, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"userContext\":");
    try aws.json.writeValue(@TypeOf(input.user_context), input.user_context, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartPatientInsightsJobOutput {
    const result: StartPatientInsightsJobOutput = try aws.json.parseJsonObject(
        StartPatientInsightsJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
