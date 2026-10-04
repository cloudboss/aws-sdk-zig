const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TransformParameters = @import("transform_parameters.zig").TransformParameters;
const WorkerType = @import("worker_type.zig").WorkerType;

pub const UpdateMLTransformInput = struct {
    /// A description of the transform. The default is an empty string.
    description: ?[]const u8 = null,

    /// This value determines which version of Glue this machine learning transform
    /// is compatible with. Glue 1.0 is recommended for most customers. If the value
    /// is not set, the Glue compatibility defaults to Glue 0.9. For more
    /// information, see [Glue
    /// Versions](https://docs.aws.amazon.com/glue/latest/dg/release-notes.html#release-notes-versions) in the developer guide.
    glue_version: ?[]const u8 = null,

    /// The number of Glue data processing units (DPUs) that are allocated to task
    /// runs for this transform. You can allocate from 2 to 100 DPUs; the default is
    /// 10. A DPU is a relative measure of
    /// processing power that consists of 4 vCPUs of compute capacity and 16 GB of
    /// memory. For more
    /// information, see the [Glue pricing
    /// page](https://aws.amazon.com/glue/pricing/).
    ///
    /// When the `WorkerType` field is set to a value other than `Standard`, the
    /// `MaxCapacity` field is set automatically and becomes read-only.
    max_capacity: ?f64 = null,

    /// The maximum number of times to retry a task for this transform after a task
    /// run fails.
    max_retries: ?i32 = null,

    /// The unique name that you gave the transform when you created it.
    name: ?[]const u8 = null,

    /// The number of workers of a defined `workerType` that are allocated when this
    /// task runs.
    number_of_workers: ?i32 = null,

    /// The configuration parameters that are specific to the transform type
    /// (algorithm) used.
    /// Conditionally dependent on the transform type.
    parameters: ?TransformParameters = null,

    /// The name or Amazon Resource Name (ARN) of the IAM role with the required
    /// permissions.
    role: ?[]const u8 = null,

    /// The timeout for a task run for this transform in minutes. This is the
    /// maximum time that a task run for this transform can consume resources before
    /// it is terminated and enters `TIMEOUT` status. The default is 2,880 minutes
    /// (48 hours).
    timeout: ?i32 = null,

    /// A unique identifier that was generated when the transform was created.
    transform_id: []const u8,

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
    worker_type: ?WorkerType = null,

    pub const json_field_names = .{
        .description = "Description",
        .glue_version = "GlueVersion",
        .max_capacity = "MaxCapacity",
        .max_retries = "MaxRetries",
        .name = "Name",
        .number_of_workers = "NumberOfWorkers",
        .parameters = "Parameters",
        .role = "Role",
        .timeout = "Timeout",
        .transform_id = "TransformId",
        .worker_type = "WorkerType",
    };
};

pub const UpdateMLTransformOutput = struct {
    /// The unique identifier for the transform that was updated.
    transform_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .transform_id = "TransformId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMLTransformInput, options: CallOptions) !UpdateMLTransformOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMLTransformInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSGlue.UpdateMLTransform");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateMLTransformOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(UpdateMLTransformOutput, body, allocator);
}
