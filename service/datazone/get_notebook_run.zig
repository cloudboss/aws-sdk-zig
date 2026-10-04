const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CellInformation = @import("cell_information.zig").CellInformation;
const ComputeConfig = @import("compute_config.zig").ComputeConfig;
const EnvironmentConfig = @import("environment_config.zig").EnvironmentConfig;
const NotebookRunError = @import("notebook_run_error.zig").NotebookRunError;
const NetworkConfig = @import("network_config.zig").NetworkConfig;
const NotificationConfig = @import("notification_config.zig").NotificationConfig;
const NotebookRunStatus = @import("notebook_run_status.zig").NotebookRunStatus;
const StorageConfig = @import("storage_config.zig").StorageConfig;
const TimeoutConfig = @import("timeout_config.zig").TimeoutConfig;
const TriggerSource = @import("trigger_source.zig").TriggerSource;

pub const GetNotebookRunInput = struct {
    /// The identifier of the Amazon SageMaker Unified Studio domain in which the
    /// notebook run exists.
    domain_identifier: []const u8,

    /// The identifier of the notebook run.
    identifier: []const u8,

    pub const json_field_names = .{
        .domain_identifier = "domainIdentifier",
        .identifier = "identifier",
    };
};

pub const GetNotebookRunOutput = struct {
    /// The ordered list of cells in the notebook run.
    cell_order: ?[]const CellInformation = null,

    /// The timestamp of when the notebook run completed.
    completed_at: ?i64 = null,

    /// The compute configuration of the notebook run.
    compute_configuration: ?ComputeConfig = null,

    /// The timestamp of when the notebook run was created.
    created_at: ?i64 = null,

    /// The identifier of the user who created the notebook run.
    created_by: ?[]const u8 = null,

    /// The identifier of the Amazon SageMaker Unified Studio domain.
    domain_id: []const u8,

    /// The environment configuration of the notebook run, including image version
    /// and package settings.
    environment_configuration: ?EnvironmentConfig = null,

    /// The error details if the notebook run failed.
    @"error": ?NotebookRunError = null,

    /// The identifier of the notebook run.
    id: []const u8,

    /// The metadata of the notebook run.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// The network configuration of the notebook run.
    network_configuration: ?NetworkConfig = null,

    /// The identifier of the notebook.
    notebook_id: []const u8,

    /// The notification configuration of the notebook run, including the notebook
    /// run states that trigger notifications.
    notification_configuration: ?NotificationConfig = null,

    /// The identifier of the project that owns the notebook run.
    owning_project_id: []const u8,

    /// The sensitive parameters of the notebook run.
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// The identifier of the schedule associated with the notebook run.
    schedule_id: ?[]const u8 = null,

    /// The timestamp of when the notebook run started executing.
    started_at: ?i64 = null,

    /// The status of the notebook run.
    status: NotebookRunStatus,

    /// The storage configuration of the notebook run, including the Amazon Simple
    /// Storage Service path and KMS key ARN.
    storage_configuration: ?StorageConfig = null,

    /// The timeout configuration of the notebook run.
    timeout_configuration: ?TimeoutConfig = null,

    /// The source that triggered the notebook run.
    trigger_source: ?TriggerSource = null,

    /// The timestamp of when the notebook run was last updated.
    updated_at: ?i64 = null,

    /// The identifier of the user who last updated the notebook run.
    updated_by: ?[]const u8 = null,

    pub const json_field_names = .{
        .cell_order = "cellOrder",
        .completed_at = "completedAt",
        .compute_configuration = "computeConfiguration",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .domain_id = "domainId",
        .environment_configuration = "environmentConfiguration",
        .@"error" = "error",
        .id = "id",
        .metadata = "metadata",
        .network_configuration = "networkConfiguration",
        .notebook_id = "notebookId",
        .notification_configuration = "notificationConfiguration",
        .owning_project_id = "owningProjectId",
        .parameters = "parameters",
        .schedule_id = "scheduleId",
        .started_at = "startedAt",
        .status = "status",
        .storage_configuration = "storageConfiguration",
        .timeout_configuration = "timeoutConfiguration",
        .trigger_source = "triggerSource",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetNotebookRunInput, options: CallOptions) !GetNotebookRunOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datazone", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetNotebookRunInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datazone", "DataZone", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v2/domains/");
    try path_buf.appendSlice(allocator, input.domain_identifier);
    try path_buf.appendSlice(allocator, "/notebook-runs/");
    try path_buf.appendSlice(allocator, input.identifier);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetNotebookRunOutput {
    const result: GetNotebookRunOutput = try aws.json.parseJsonObject(
        GetNotebookRunOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
