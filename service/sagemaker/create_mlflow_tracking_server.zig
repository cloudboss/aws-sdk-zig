const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const TrackingServerSize = @import("tracking_server_size.zig").TrackingServerSize;

pub const CreateMlflowTrackingServerInput = struct {
    /// The S3 URI for a general purpose bucket to use as the MLflow Tracking Server
    /// artifact store.
    artifact_store_uri: []const u8,

    /// Whether to enable or disable automatic registration of new MLflow models to
    /// the SageMaker Model Registry. To enable automatic model registration, set
    /// this value to `True`. To disable automatic model registration, set this
    /// value to `False`. If not specified, `AutomaticModelRegistration` defaults to
    /// `False`.
    automatic_model_registration: ?bool = null,

    /// The version of MLflow that the tracking server uses. To see which MLflow
    /// versions are available to use, see [How it
    /// works](https://docs.aws.amazon.com/sagemaker/latest/dg/mlflow.html#mlflow-create-tracking-server-how-it-works).
    mlflow_version: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for an IAM role in your account that the
    /// MLflow Tracking Server uses to access the artifact store in Amazon S3. The
    /// role should have `AmazonS3FullAccess` permissions. For more information on
    /// IAM permissions for tracking server creation, see [Set up IAM permissions
    /// for
    /// MLflow](https://docs.aws.amazon.com/sagemaker/latest/dg/mlflow-create-tracking-server-iam.html).
    role_arn: []const u8,

    /// Expected Amazon Web Services account ID that owns the Amazon S3 bucket for
    /// artifact storage. Defaults to caller's account ID if not provided.
    s3_bucket_owner_account_id: ?[]const u8 = null,

    /// Enable Amazon S3 Ownership checks when interacting with Amazon S3 buckets
    /// from a SageMaker Managed MLflow Tracking Server. Defaults to `True` if not
    /// provided.
    s3_bucket_owner_verification: ?bool = null,

    /// Tags consisting of key-value pairs used to manage metadata for the tracking
    /// server.
    tags: ?[]const Tag = null,

    /// A unique string identifying the tracking server name. This string is part of
    /// the tracking server ARN.
    tracking_server_name: []const u8,

    /// The size of the tracking server you want to create. You can choose between
    /// `"Small"`, `"Medium"`, and `"Large"`. The default MLflow Tracking Server
    /// configuration size is `"Small"`. You can choose a size depending on the
    /// projected use of the tracking server such as the volume of data logged,
    /// number of users, and frequency of use.
    ///
    /// We recommend using a small tracking server for teams of up to 25 users, a
    /// medium tracking server for teams of up to 50 users, and a large tracking
    /// server for teams of up to 100 users.
    tracking_server_size: ?TrackingServerSize = null,

    /// The day and time of the week in Coordinated Universal Time (UTC) 24-hour
    /// standard time that weekly maintenance updates are scheduled. For example:
    /// TUE:03:30.
    weekly_maintenance_window_start: ?[]const u8 = null,

    pub const json_field_names = .{
        .artifact_store_uri = "ArtifactStoreUri",
        .automatic_model_registration = "AutomaticModelRegistration",
        .mlflow_version = "MlflowVersion",
        .role_arn = "RoleArn",
        .s3_bucket_owner_account_id = "S3BucketOwnerAccountId",
        .s3_bucket_owner_verification = "S3BucketOwnerVerification",
        .tags = "Tags",
        .tracking_server_name = "TrackingServerName",
        .tracking_server_size = "TrackingServerSize",
        .weekly_maintenance_window_start = "WeeklyMaintenanceWindowStart",
    };
};

pub const CreateMlflowTrackingServerOutput = struct {
    /// The ARN of the tracking server.
    tracking_server_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .tracking_server_arn = "TrackingServerArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMlflowTrackingServerInput, options: CallOptions) !CreateMlflowTrackingServerOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMlflowTrackingServerInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "SageMaker.CreateMlflowTrackingServer");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMlflowTrackingServerOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateMlflowTrackingServerOutput, body, allocator);
}
