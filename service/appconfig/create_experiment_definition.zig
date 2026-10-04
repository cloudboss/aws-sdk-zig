const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TreatmentInput = @import("treatment_input.zig").TreatmentInput;
const Treatment = @import("treatment.zig").Treatment;
const ExperimentDefinitionStatus = @import("experiment_definition_status.zig").ExperimentDefinitionStatus;

pub const CreateExperimentDefinitionInput = struct {
    /// The application ID or name.
    application_identifier: []const u8,

    /// A description of the intended audience for the experiment.
    audience_description: ?[]const u8 = null,

    /// A rule that defines which users are eligible to be assigned to treatments
    /// during the experiment.
    audience_rule: []const u8,

    /// The configuration profile ID or name that stores the feature flag.
    configuration_profile_identifier: []const u8,

    /// The control treatment that represents the baseline experience for
    /// comparison.
    control: TreatmentInput,

    /// The environment ID or name where the experiment will run.
    environment_identifier: []const u8,

    /// The key of the existing feature flag to use with the experiment.
    flag_key: []const u8,

    /// A description of the goal or hypothesis the experiment is designed to
    /// validate.
    hypothesis: ?[]const u8 = null,

    /// Information about the conditions under which you would launch the winning
    /// treatment.
    launch_criteria: ?[]const u8 = null,

    /// A name for the experiment definition.
    name: []const u8,

    /// The tags to assign to the experiment definition. Tags help organize and
    /// categorize your AppConfig resources.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A list of treatments to evaluate during the experiment. Each treatment
    /// defines a distinct variation compared to the control.
    treatments: []const TreatmentInput,

    pub const json_field_names = .{
        .application_identifier = "ApplicationIdentifier",
        .audience_description = "AudienceDescription",
        .audience_rule = "AudienceRule",
        .configuration_profile_identifier = "ConfigurationProfileIdentifier",
        .control = "Control",
        .environment_identifier = "EnvironmentIdentifier",
        .flag_key = "FlagKey",
        .hypothesis = "Hypothesis",
        .launch_criteria = "LaunchCriteria",
        .name = "Name",
        .tags = "Tags",
        .treatments = "Treatments",
    };
};

pub const CreateExperimentDefinitionOutput = struct {
    /// The application ID.
    application_id: ?[]const u8 = null,

    /// A description of the intended audience for the experiment.
    audience_description: ?[]const u8 = null,

    /// The rule that defines which users are eligible to be assigned to treatments.
    audience_rule: ?[]const u8 = null,

    /// The configuration profile ID associated with the experiment.
    configuration_profile_id: ?[]const u8 = null,

    /// The control treatment used as the baseline for comparison.
    control: ?Treatment = null,

    /// The date and time the experiment definition was created, in ISO 8601 format.
    created_at: ?i64 = null,

    /// The environment ID where the experiment runs.
    environment_id: ?[]const u8 = null,

    /// The key of the feature flag used by the experiment.
    flag_key: ?[]const u8 = null,

    /// The hypothesis that the experiment is designed to validate.
    hypothesis: ?[]const u8 = null,

    /// The experiment definition ID.
    id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the KMS key used to encrypt experiment
    /// data.
    kms_key_identifier: ?[]const u8 = null,

    /// The conditions under which the winning treatment should be launched.
    launch_criteria: ?[]const u8 = null,

    /// The name of the experiment definition.
    name: ?[]const u8 = null,

    /// The current status of the experiment definition. Valid values: `ACTIVE`,
    /// `IDLE`, `ARCHIVED`.
    status: ?ExperimentDefinitionStatus = null,

    /// The list of treatments defined for the experiment.
    treatments: ?[]const Treatment = null,

    /// The date and time the experiment definition was last updated, in ISO 8601
    /// format.
    updated_at: ?i64 = null,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .audience_description = "AudienceDescription",
        .audience_rule = "AudienceRule",
        .configuration_profile_id = "ConfigurationProfileId",
        .control = "Control",
        .created_at = "CreatedAt",
        .environment_id = "EnvironmentId",
        .flag_key = "FlagKey",
        .hypothesis = "Hypothesis",
        .id = "Id",
        .kms_key_identifier = "KmsKeyIdentifier",
        .launch_criteria = "LaunchCriteria",
        .name = "Name",
        .status = "Status",
        .treatments = "Treatments",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateExperimentDefinitionInput, options: CallOptions) !CreateExperimentDefinitionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateExperimentDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appconfig", "AppConfig", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_identifier);
    try path_buf.appendSlice(allocator, "/experimentdefinitions");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.audience_description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"AudienceDescription\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AudienceRule\":");
    try aws.json.writeValue(@TypeOf(input.audience_rule), input.audience_rule, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ConfigurationProfileIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.configuration_profile_identifier), input.configuration_profile_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Control\":");
    try aws.json.writeValue(@TypeOf(input.control), input.control, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"EnvironmentIdentifier\":");
    try aws.json.writeValue(@TypeOf(input.environment_identifier), input.environment_identifier, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"FlagKey\":");
    try aws.json.writeValue(@TypeOf(input.flag_key), input.flag_key, allocator, &body_buf);
    has_prev = true;
    if (input.hypothesis) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Hypothesis\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.launch_criteria) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"LaunchCriteria\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Treatments\":");
    try aws.json.writeValue(@TypeOf(input.treatments), input.treatments, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateExperimentDefinitionOutput {
    const result: CreateExperimentDefinitionOutput = try aws.json.parseJsonObject(
        CreateExperimentDefinitionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
