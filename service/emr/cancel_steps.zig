const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StepCancellationOption = @import("step_cancellation_option.zig").StepCancellationOption;
const CancelStepsInfo = @import("cancel_steps_info.zig").CancelStepsInfo;

pub const CancelStepsInput = struct {
    /// The `ClusterID` for the specified steps that will be canceled. Use
    /// RunJobFlow and ListClusters to get ClusterIDs.
    cluster_id: []const u8,

    /// The option to choose to cancel `RUNNING` steps. By default, the value is
    /// `SEND_INTERRUPT`.
    step_cancellation_option: ?StepCancellationOption = null,

    /// The list of `StepIDs` to cancel. Use ListSteps to get steps
    /// and their states for the specified cluster.
    step_ids: []const []const u8,

    pub const json_field_names = .{
        .cluster_id = "ClusterId",
        .step_cancellation_option = "StepCancellationOption",
        .step_ids = "StepIds",
    };
};

pub const CancelStepsOutput = struct {
    /// A list of CancelStepsInfo, which shows the status of specified cancel
    /// requests for each `StepID` specified.
    cancel_steps_info_list: ?[]const CancelStepsInfo = null,

    pub const json_field_names = .{
        .cancel_steps_info_list = "CancelStepsInfoList",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CancelStepsInput, options: CallOptions) !CancelStepsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "elasticmapreduce", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CancelStepsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("elasticmapreduce", "EMR", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "ElasticMapReduce.CancelSteps");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CancelStepsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CancelStepsOutput, body, allocator);
}
