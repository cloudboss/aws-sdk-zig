const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AccountDefaultStatus = @import("account_default_status.zig").AccountDefaultStatus;
const ModelRegistrationMode = @import("model_registration_mode.zig").ModelRegistrationMode;

pub const UpdateMlflowAppInput = struct {
    /// Indicates whether this this MLflow App is the default for the account.
    account_default_status: ?AccountDefaultStatus = null,

    /// The ARN of the MLflow App to update.
    arn: []const u8,

    /// The new S3 URI for the general purpose bucket to use as the artifact store
    /// for the MLflow App.
    artifact_store_uri: ?[]const u8 = null,

    /// List of SageMaker Domain IDs for which this MLflow App is the default.
    default_domain_id_list: ?[]const []const u8 = null,

    /// Whether to enable or disable automatic registration of new MLflow models to
    /// the SageMaker Model Registry. To enable automatic model registration, set
    /// this value to `AutoModelRegistrationEnabled`. To disable automatic model
    /// registration, set this value to `AutoModelRegistrationDisabled`. If not
    /// specified, `AutomaticModelRegistration` defaults to
    /// `AutoModelRegistrationEnabled`
    model_registration_mode: ?ModelRegistrationMode = null,

    /// The name of the MLflow App to update.
    name: ?[]const u8 = null,

    /// The new weekly maintenance window start day and time to update. The
    /// maintenance window day and time should be in Coordinated Universal Time
    /// (UTC) 24-hour standard time. For example: TUE:03:30.
    weekly_maintenance_window_start: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_default_status = "AccountDefaultStatus",
        .arn = "Arn",
        .artifact_store_uri = "ArtifactStoreUri",
        .default_domain_id_list = "DefaultDomainIdList",
        .model_registration_mode = "ModelRegistrationMode",
        .name = "Name",
        .weekly_maintenance_window_start = "WeeklyMaintenanceWindowStart",
    };
};

pub const UpdateMlflowAppOutput = struct {
    /// The ARN of the updated MLflow App.
    arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMlflowAppInput, options: CallOptions) !UpdateMlflowAppOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "sagemaker", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMlflowAppInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.sagemaker", "SageMaker", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateMlflowApp");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateMlflowAppOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateMlflowAppOutput, body, allocator);
}
