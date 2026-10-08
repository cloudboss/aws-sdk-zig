const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PatientInsightsEncounterContext = @import("patient_insights_encounter_context.zig").PatientInsightsEncounterContext;
const InputDataConfig = @import("input_data_config.zig").InputDataConfig;
const InsightsContext = @import("insights_context.zig").InsightsContext;
const InsightsOutput = @import("insights_output.zig").InsightsOutput;
const JobStatus = @import("job_status.zig").JobStatus;
const OutputDataConfig = @import("output_data_config.zig").OutputDataConfig;
const PatientInsightsPatientContext = @import("patient_insights_patient_context.zig").PatientInsightsPatientContext;
const UserContext = @import("user_context.zig").UserContext;

pub const GetPatientInsightsJobInput = struct {
    domain_id: []const u8,

    job_id: []const u8,

    pub const json_field_names = .{
        .domain_id = "domainId",
        .job_id = "jobId",
    };
};

pub const GetPatientInsightsJobOutput = struct {
    /// Date and time the patient insights job was submitted.
    creation_time: ?i64 = null,

    encounter_context: ?PatientInsightsEncounterContext = null,

    input_data_config: ?InputDataConfig = null,

    insights_context: ?InsightsContext = null,

    insights_output: ?InsightsOutput = null,

    job_arn: []const u8,

    job_id: []const u8,

    job_status: JobStatus,

    output_data_config: ?OutputDataConfig = null,

    patient_context: ?PatientInsightsPatientContext = null,

    /// Contains information about the status of a job.
    status_details: ?[]const u8 = null,

    /// Date and time the patient insights job was last updated.
    updated_time: ?i64 = null,

    user_context: ?UserContext = null,

    pub const json_field_names = .{
        .creation_time = "creationTime",
        .encounter_context = "encounterContext",
        .input_data_config = "inputDataConfig",
        .insights_context = "insightsContext",
        .insights_output = "insightsOutput",
        .job_arn = "jobArn",
        .job_id = "jobId",
        .job_status = "jobStatus",
        .output_data_config = "outputDataConfig",
        .patient_context = "patientContext",
        .status_details = "statusDetails",
        .updated_time = "updatedTime",
        .user_context = "userContext",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetPatientInsightsJobInput, options: CallOptions) !GetPatientInsightsJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetPatientInsightsJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("health-agent", "ConnectHealth", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/domain/");
    try path_buf.appendSlice(allocator, input.domain_id);
    try path_buf.appendSlice(allocator, "/patient-insights-job/");
    try path_buf.appendSlice(allocator, input.job_id);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetPatientInsightsJobOutput {
    const result: GetPatientInsightsJobOutput = try aws.json.parseJsonObject(
        GetPatientInsightsJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
