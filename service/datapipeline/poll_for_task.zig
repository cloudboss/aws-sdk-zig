const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const InstanceIdentity = @import("instance_identity.zig").InstanceIdentity;
const TaskObject = @import("task_object.zig").TaskObject;

pub const PollForTaskInput = struct {
    /// The public DNS name of the calling task runner.
    hostname: ?[]const u8 = null,

    /// Identity information for the EC2 instance that is hosting the task runner.
    /// You can get this value from the instance using
    /// `http://169.254.169.254/latest/meta-data/instance-id`. For more information,
    /// see [Instance
    /// Metadata](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AESDG-chapter-instancedata.html) in the *Amazon Elastic Compute Cloud User Guide.* Passing in this value proves that your task runner is running on an EC2 instance, and ensures the proper AWS Data Pipeline service charges are applied to your pipeline.
    instance_identity: ?InstanceIdentity = null,

    /// The type of task the task runner is configured to accept and process. The
    /// worker group is set as a field on objects in the pipeline when they are
    /// created.
    /// You can only specify a single value for `workerGroup` in the call to
    /// `PollForTask`. There are no wildcard values permitted in
    /// `workerGroup`; the string must be an exact, case-sensitive, match.
    worker_group: []const u8,

    pub const json_field_names = .{
        .hostname = "hostname",
        .instance_identity = "instanceIdentity",
        .worker_group = "workerGroup",
    };
};

pub const PollForTaskOutput = struct {
    /// The information needed to complete the task that is being assigned to the
    /// task runner. One of the fields returned in this object is `taskId`,
    /// which contains an identifier for the task being assigned. The calling task
    /// runner uses `taskId` in subsequent calls to ReportTaskProgress
    /// and SetTaskStatus.
    task_object: ?TaskObject = null,

    pub const json_field_names = .{
        .task_object = "taskObject",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PollForTaskInput, options: CallOptions) !PollForTaskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "datapipeline", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PollForTaskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datapipeline", "Data Pipeline", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "DataPipeline.PollForTask");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PollForTaskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(PollForTaskOutput, body, allocator);
}
