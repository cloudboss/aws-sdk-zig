const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GlueTable = @import("glue_table.zig").GlueTable;
const TransformParameters = @import("transform_parameters.zig").TransformParameters;
const TransformEncryption = @import("transform_encryption.zig").TransformEncryption;
const WorkerType = @import("worker_type.zig").WorkerType;

pub const CreateMLTransformInput = struct {
    /// A description of the machine learning transform that is being defined. The
    /// default is an
    /// empty string.
    description: ?[]const u8 = null,

    /// This value determines which version of Glue this machine learning transform
    /// is compatible with. Glue 1.0 is recommended for most customers. If the value
    /// is not set, the Glue compatibility defaults to Glue 0.9. For more
    /// information, see [Glue
    /// Versions](https://docs.aws.amazon.com/glue/latest/dg/release-notes.html#release-notes-versions) in the developer guide.
    glue_version: ?[]const u8 = null,

    /// A list of Glue table definitions used by the transform.
    input_record_tables: []const GlueTable,

    /// The number of Glue data processing units (DPUs) that are allocated to task
    /// runs for this transform. You can allocate from 2 to 100 DPUs; the default is
    /// 10. A DPU is a relative measure of
    /// processing power that consists of 4 vCPUs of compute capacity and 16 GB of
    /// memory. For more
    /// information, see the [Glue pricing
    /// page](https://aws.amazon.com/glue/pricing/).
    ///
    /// `MaxCapacity` is a mutually exclusive option with `NumberOfWorkers` and
    /// `WorkerType`.
    ///
    /// * If either `NumberOfWorkers` or `WorkerType` is set, then `MaxCapacity`
    ///   cannot be set.
    ///
    /// * If `MaxCapacity` is set then neither `NumberOfWorkers` or `WorkerType` can
    ///   be set.
    ///
    /// * If `WorkerType` is set, then `NumberOfWorkers` is required (and vice
    ///   versa).
    ///
    /// * `MaxCapacity` and `NumberOfWorkers` must both be at least 1.
    ///
    /// When the `WorkerType` field is set to a value other than `Standard`, the
    /// `MaxCapacity` field is set automatically and becomes read-only.
    ///
    /// When the `WorkerType` field is set to a value other than `Standard`, the
    /// `MaxCapacity` field is set automatically and becomes read-only.
    max_capacity: ?f64 = null,

    /// The maximum number of times to retry a task for this transform after a task
    /// run fails.
    max_retries: ?i32 = null,

    /// The unique name that you give the transform when you create it.
    name: []const u8,

    /// The number of workers of a defined `workerType` that are allocated when this
    /// task runs.
    ///
    /// If `WorkerType` is set, then `NumberOfWorkers` is required (and vice versa).
    number_of_workers: ?i32 = null,

    /// The algorithmic parameters that are specific to the transform type used.
    /// Conditionally
    /// dependent on the transform type.
    parameters: TransformParameters,

    /// The name or Amazon Resource Name (ARN) of the IAM role with the required
    /// permissions. The required permissions include both Glue service role
    /// permissions to Glue resources, and Amazon S3 permissions required by the
    /// transform.
    ///
    /// * This role needs Glue service role permissions to allow access to resources
    ///   in Glue. See [Attach a Policy to IAM Users That Access
    ///   Glue](https://docs.aws.amazon.com/glue/latest/dg/attach-policy-iam-user.html).
    ///
    /// * This role needs permission to your Amazon Simple Storage Service (Amazon
    ///   S3) sources, targets, temporary directory, scripts, and any libraries used
    ///   by the task run for this transform.
    role: []const u8,

    /// The tags to use with this machine learning transform. You may use tags to
    /// limit access to the machine learning transform. For more information about
    /// tags in Glue, see [Amazon Web Services Tags in
    /// Glue](https://docs.aws.amazon.com/glue/latest/dg/monitor-tags.html) in the
    /// developer guide.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timeout of the task run for this transform in minutes. This is the
    /// maximum time that a task run for this transform can consume resources before
    /// it is terminated and enters `TIMEOUT` status. The default is 2,880 minutes
    /// (48 hours).
    timeout: ?i32 = null,

    /// The encryption-at-rest settings of the transform that apply to accessing
    /// user data. Machine learning transforms can access user data encrypted in
    /// Amazon S3 using KMS.
    transform_encryption: ?TransformEncryption = null,

    /// The type of predefined worker that is allocated when this task runs. Accepts
    /// a value of Standard, G.1X, or G.2X.
    ///
    /// * For the `Standard` worker type, each worker provides 4 vCPU, 16 GB of
    ///   memory and a 50GB disk, and 2 executors per worker.
    ///
    /// * For the `G.1X` worker type, each worker provides 4 vCPU, 16 GB of memory
    ///   and a 64GB disk, and 1 executor per worker.
    ///
    /// * For the `G.2X` worker type, each worker provides 8 vCPU, 32 GB of memory
    ///   and a 128GB disk, and 1 executor per worker.
    ///
    /// `MaxCapacity` is a mutually exclusive option with `NumberOfWorkers` and
    /// `WorkerType`.
    ///
    /// * If either `NumberOfWorkers` or `WorkerType` is set, then `MaxCapacity`
    ///   cannot be set.
    ///
    /// * If `MaxCapacity` is set then neither `NumberOfWorkers` or `WorkerType` can
    ///   be set.
    ///
    /// * If `WorkerType` is set, then `NumberOfWorkers` is required (and vice
    ///   versa).
    ///
    /// * `MaxCapacity` and `NumberOfWorkers` must both be at least 1.
    worker_type: ?WorkerType = null,

    pub const json_field_names = .{
        .description = "Description",
        .glue_version = "GlueVersion",
        .input_record_tables = "InputRecordTables",
        .max_capacity = "MaxCapacity",
        .max_retries = "MaxRetries",
        .name = "Name",
        .number_of_workers = "NumberOfWorkers",
        .parameters = "Parameters",
        .role = "Role",
        .tags = "Tags",
        .timeout = "Timeout",
        .transform_encryption = "TransformEncryption",
        .worker_type = "WorkerType",
    };
};

pub const CreateMLTransformOutput = struct {
    /// A unique identifier that is generated for the transform.
    transform_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .transform_id = "TransformId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateMLTransformInput, options: CallOptions) !CreateMLTransformOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glue", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateMLTransformInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glue", "Glue", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.CreateMLTransform");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateMLTransformOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateMLTransformOutput, body, allocator);
}
