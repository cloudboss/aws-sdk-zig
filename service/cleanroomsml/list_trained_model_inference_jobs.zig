const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TrainedModelInferenceJobSummary = @import("trained_model_inference_job_summary.zig").TrainedModelInferenceJobSummary;

pub const ListTrainedModelInferenceJobsInput = struct {
    /// The maximum size of the results that is returned per call.
    max_results: ?i32 = null,

    /// The membership
    membership_identifier: []const u8,

    /// The token value retrieved from a previous call to access the next page of
    /// results.
    next_token: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of a trained model that was used to create
    /// the trained model inference jobs that you are interested in.
    trained_model_arn: ?[]const u8 = null,

    /// The version identifier of the trained model to filter inference jobs by.
    /// When specified, only inference jobs that used this specific version of the
    /// trained model are returned.
    trained_model_version_identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .membership_identifier = "membershipIdentifier",
        .next_token = "nextToken",
        .trained_model_arn = "trainedModelArn",
        .trained_model_version_identifier = "trainedModelVersionIdentifier",
    };
};

pub const ListTrainedModelInferenceJobsOutput = struct {
    /// The token value used to access the next page of results.
    next_token: ?[]const u8 = null,

    /// Returns the requested trained model inference jobs.
    trained_model_inference_jobs: ?[]const TrainedModelInferenceJobSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .trained_model_inference_jobs = "trainedModelInferenceJobs",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTrainedModelInferenceJobsInput, options: CallOptions) !ListTrainedModelInferenceJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cleanrooms-ml", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTrainedModelInferenceJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms-ml", "CleanRoomsML", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memberships/");
    try path_buf.appendSlice(allocator, input.membership_identifier);
    try path_buf.appendSlice(allocator, "/trained-model-inference-jobs");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_results) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxResults=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.next_token) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "nextToken=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.trained_model_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "trainedModelArn=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.trained_model_version_identifier) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "trainedModelVersionIdentifier=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTrainedModelInferenceJobsOutput {
    const result: ListTrainedModelInferenceJobsOutput = try aws.json.parseJsonObject(
        ListTrainedModelInferenceJobsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
