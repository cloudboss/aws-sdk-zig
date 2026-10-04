const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const ListMLModelTrainingJobsInput = struct {
    /// The maximum number of items to return (from 1 to 1024; the default is 10).
    max_items: ?i32 = null,

    /// The ARN of an IAM role that provides Neptune access to SageMaker and Amazon
    /// S3 resources. This must be listed in your DB cluster parameter group or an
    /// error will occur.
    neptune_iam_role_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .max_items = "maxItems",
        .neptune_iam_role_arn = "neptuneIamRoleArn",
    };
};

pub const ListMLModelTrainingJobsOutput = struct {
    /// A page of the list of model training job IDs.
    ids: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .ids = "ids",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListMLModelTrainingJobsInput, options: CallOptions) !ListMLModelTrainingJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "neptune-db", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListMLModelTrainingJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("neptune-db", "neptunedata", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ml/modeltraining";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.max_items) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "maxItems=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.neptune_iam_role_arn) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "neptuneIamRoleArn=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListMLModelTrainingJobsOutput {
    var result: ListMLModelTrainingJobsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(ListMLModelTrainingJobsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
