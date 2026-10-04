const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Treatment = @import("treatment.zig").Treatment;
const ExperimentDefinitionStatus = @import("experiment_definition_status.zig").ExperimentDefinitionStatus;

pub const GetExperimentDefinitionInput = struct {
    /// The application ID or name.
    application_identifier: []const u8,

    /// The experiment definition ID or name.
    experiment_definition_identifier: []const u8,

    pub const json_field_names = .{
        .application_identifier = "ApplicationIdentifier",
        .experiment_definition_identifier = "ExperimentDefinitionIdentifier",
    };
};

pub const GetExperimentDefinitionOutput = struct {
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetExperimentDefinitionInput, options: CallOptions) !GetExperimentDefinitionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetExperimentDefinitionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("appconfig", "AppConfig", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/applications/");
    try path_buf.appendSlice(allocator, input.application_identifier);
    try path_buf.appendSlice(allocator, "/experimentdefinitions/");
    try path_buf.appendSlice(allocator, input.experiment_definition_identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetExperimentDefinitionOutput {
    const result: GetExperimentDefinitionOutput = try aws.json.parseJsonObject(
        GetExperimentDefinitionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
