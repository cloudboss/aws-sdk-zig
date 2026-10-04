const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const TrainedModelStatus = @import("trained_model_status.zig").TrainedModelStatus;
const TrainedModelSummary = @import("trained_model_summary.zig").TrainedModelSummary;

pub const ListTrainedModelVersionsInput = struct {
    /// The maximum number of trained model versions to return in a single page. The
    /// default value is 10, and the maximum value is 100.
    max_results: ?i32 = null,

    /// The membership identifier for the collaboration that contains the trained
    /// model.
    membership_identifier: []const u8,

    /// The pagination token from a previous `ListTrainedModelVersions` request. Use
    /// this token to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    /// Filter the results to only include trained model versions with the specified
    /// status. Valid values include `CREATE_PENDING`, `CREATE_IN_PROGRESS`,
    /// `ACTIVE`, `CREATE_FAILED`, and others.
    status: ?TrainedModelStatus = null,

    /// The Amazon Resource Name (ARN) of the trained model for which to list
    /// versions.
    trained_model_arn: []const u8,

    pub const json_field_names = .{
        .max_results = "maxResults",
        .membership_identifier = "membershipIdentifier",
        .next_token = "nextToken",
        .status = "status",
        .trained_model_arn = "trainedModelArn",
    };
};

pub const ListTrainedModelVersionsOutput = struct {
    /// The pagination token to use in a subsequent `ListTrainedModelVersions`
    /// request to retrieve the next page of results. This value is null when there
    /// are no more results to return.
    next_token: ?[]const u8 = null,

    /// A list of trained model versions that match the specified criteria. Each
    /// entry contains summary information about a trained model version, including
    /// its version identifier, status, and creation details.
    trained_models: ?[]const TrainedModelSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .trained_models = "trainedModels",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListTrainedModelVersionsInput, options: CallOptions) !ListTrainedModelVersionsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListTrainedModelVersionsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cleanrooms-ml", "CleanRoomsML", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/memberships/");
    try path_buf.appendSlice(allocator, input.membership_identifier);
    try path_buf.appendSlice(allocator, "/trained-models/");
    try path_buf.appendSlice(allocator, input.trained_model_arn);
    try path_buf.appendSlice(allocator, "/versions");
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
    if (input.status) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "status=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v.wireName());
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListTrainedModelVersionsOutput {
    const result: ListTrainedModelVersionsOutput = try aws.json.parseJsonObject(
        ListTrainedModelVersionsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
