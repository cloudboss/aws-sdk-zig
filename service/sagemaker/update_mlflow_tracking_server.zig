const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TrackingServerSize = @import("tracking_server_size.zig").TrackingServerSize;

pub const UpdateMlflowTrackingServerInput = struct {
    /// The new S3 URI for the general purpose bucket to use as the artifact store
    /// for the MLflow Tracking Server.
    artifact_store_uri: ?[]const u8 = null,

    /// Whether to enable or disable automatic registration of new MLflow models to
    /// the SageMaker Model Registry. To enable automatic model registration, set
    /// this value to `True`. To disable automatic model registration, set this
    /// value to `False`. If not specified, `AutomaticModelRegistration` defaults to
    /// `False`
    automatic_model_registration: ?bool = null,

    /// The new expected Amazon Web Services account ID that owns the Amazon S3
    /// bucket for artifact storage.
    s3_bucket_owner_account_id: ?[]const u8 = null,

    /// Whether to enable or disable Amazon S3 Bucket Owenrship Verifaction whenever
    /// the MLflow Tracking Server interacts with Amazon Amazon S3.
    s3_bucket_owner_verification: ?bool = null,

    /// The name of the MLflow Tracking Server to update.
    tracking_server_name: []const u8,

    /// The new size for the MLflow Tracking Server.
    tracking_server_size: ?TrackingServerSize = null,

    /// The new weekly maintenance window start day and time to update. The
    /// maintenance window day and time should be in Coordinated Universal Time
    /// (UTC) 24-hour standard time. For example: TUE:03:30.
    weekly_maintenance_window_start: ?[]const u8 = null,

    pub const json_field_names = .{
        .artifact_store_uri = "ArtifactStoreUri",
        .automatic_model_registration = "AutomaticModelRegistration",
        .s3_bucket_owner_account_id = "S3BucketOwnerAccountId",
        .s3_bucket_owner_verification = "S3BucketOwnerVerification",
        .tracking_server_name = "TrackingServerName",
        .tracking_server_size = "TrackingServerSize",
        .weekly_maintenance_window_start = "WeeklyMaintenanceWindowStart",
    };
};

pub const UpdateMlflowTrackingServerOutput = struct {
    /// The ARN of the updated MLflow Tracking Server.
    tracking_server_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .tracking_server_arn = "TrackingServerArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMlflowTrackingServerInput, options: CallOptions) !UpdateMlflowTrackingServerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMlflowTrackingServerInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.UpdateMlflowTrackingServer");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateMlflowTrackingServerOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateMlflowTrackingServerOutput, body, allocator);
}
