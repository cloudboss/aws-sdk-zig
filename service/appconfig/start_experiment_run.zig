const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DeploymentParameters = @import("deployment_parameters.zig").DeploymentParameters;
const TreatmentOverrides = @import("treatment_overrides.zig").TreatmentOverrides;
const ExperimentDefinitionSnapshot = @import("experiment_definition_snapshot.zig").ExperimentDefinitionSnapshot;
const ExperimentRunResult = @import("experiment_run_result.zig").ExperimentRunResult;
const ExperimentRunStatus = @import("experiment_run_status.zig").ExperimentRunStatus;

pub const StartExperimentRunInput = struct {
    /// The application ID or name.
    application_identifier: []const u8,

    /// The deployment parameters for the experiment run, including a KMS key
    /// identifier for encryption.
    deployment_parameters: ?DeploymentParameters = null,

    /// A description of this experiment run.
    description: ?[]const u8 = null,

    /// The experiment definition ID or name.
    experiment_definition_identifier: []const u8,

    /// The percentage of the target audience to expose to treatments. Set to 0 to
    /// validate the experiment before exposing production users.
    exposure_percentage: ?f32 = null,

    /// The tags to assign to the experiment run.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Treatment assignment overrides that assign specific entity IDs to treatments
    /// directly, bypassing random assignment.
    treatment_overrides: ?TreatmentOverrides = null,

    pub const json_field_names = .{
        .application_identifier = "ApplicationIdentifier",
        .deployment_parameters = "DeploymentParameters",
        .description = "Description",
        .experiment_definition_identifier = "ExperimentDefinitionIdentifier",
        .exposure_percentage = "ExposurePercentage",
        .tags = "Tags",
        .treatment_overrides = "TreatmentOverrides",
    };
};

pub const StartExperimentRunOutput = struct {
    /// The application ID.
    application_id: ?[]const u8 = null,

    /// A description of the experiment run.
    description: ?[]const u8 = null,

    /// The date and time the experiment run ended, in ISO 8601 format.
    ended_at: ?i64 = null,

    /// The experiment definition ID.
    experiment_definition_id: ?[]const u8 = null,

    /// A snapshot of the experiment definition at the time the run was started.
    experiment_definition_snapshot: ?ExperimentDefinitionSnapshot = null,

    /// The percentage of the target audience exposed to treatments.
    exposure_percentage: ?f32 = null,

    /// The result of the experiment run, including the executive summary and launch
    /// decision rationale.
    result: ?ExperimentRunResult = null,

    /// The experiment run number.
    run: ?i32 = null,

    /// The date and time the experiment run started, in ISO 8601 format.
    started_at: ?i64 = null,

    /// The current status of the experiment run. Valid values: `RUNNING`, `DONE`.
    status: ?ExperimentRunStatus = null,

    /// Treatment assignment overrides that assign specific entity IDs to
    /// treatments.
    treatment_overrides: ?TreatmentOverrides = null,

    /// The date and time the experiment run was last updated, in ISO 8601 format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .description = "Description",
        .ended_at = "EndedAt",
        .experiment_definition_id = "ExperimentDefinitionId",
        .experiment_definition_snapshot = "ExperimentDefinitionSnapshot",
        .exposure_percentage = "ExposurePercentage",
        .result = "Result",
        .run = "Run",
        .started_at = "StartedAt",
        .status = "Status",
        .treatment_overrides = "TreatmentOverrides",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartExperimentRunInput, options: CallOptions) !StartExperimentRunOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "appconfig", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartExperimentRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appconfig", "AppConfig", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_identifier);
    try path_buf.appendSlice(allocator, "/experimentdefinitions/");
    try path_buf.appendSlice(allocator, input.experiment_definition_identifier);
    try path_buf.appendSlice(allocator, "/experimentruns");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.deployment_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DeploymentParameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.exposure_percentage) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ExposurePercentage\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.treatment_overrides) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TreatmentOverrides\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartExperimentRunOutput {
    const result: StartExperimentRunOutput = try aws.json.parseJsonObject(
        StartExperimentRunOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
