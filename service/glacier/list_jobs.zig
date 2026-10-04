const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const GlacierJobDescription = @import("glacier_job_description.zig").GlacierJobDescription;

pub const ListJobsInput = struct {
    /// The `AccountId` value is the AWS account ID of the account that owns the
    /// vault. You can either specify an AWS account ID or optionally a single '`-`'
    /// (hyphen), in which case Amazon Glacier uses the AWS account ID associated
    /// with the
    /// credentials used to sign the request. If you use an account ID, do not
    /// include any hyphens
    /// ('-') in the ID.
    account_id: []const u8,

    /// The state of the jobs to return. You can specify `true` or
    /// `false`.
    completed: ?[]const u8 = null,

    /// The maximum number of jobs to be returned. The default limit is 50. The
    /// number of
    /// jobs returned might be fewer than the specified limit, but the number of
    /// returned jobs
    /// never exceeds the limit.
    limit: ?i32 = null,

    /// An opaque string used for pagination. This value specifies the job at which
    /// the
    /// listing of jobs should begin. Get the marker value from a previous List Jobs
    /// response. You
    /// only need to include the marker if you are continuing the pagination of
    /// results started in
    /// a previous List Jobs request.
    marker: ?[]const u8 = null,

    /// The type of job status to return. You can specify the following values:
    /// `InProgress`, `Succeeded`, or `Failed`.
    statuscode: ?[]const u8 = null,

    /// The name of the vault.
    vault_name: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .completed = "completed",
        .limit = "limit",
        .marker = "marker",
        .statuscode = "statuscode",
        .vault_name = "vaultName",
    };
};

pub const ListJobsOutput = struct {
    /// A list of job objects. Each job object contains metadata describing the
    /// job.
    job_list: ?[]const GlacierJobDescription = null,

    /// An opaque string used for pagination that specifies the job at which the
    /// listing of jobs should begin.
    /// You get the `marker` value from a previous List Jobs response.
    /// You only need to include the marker if you are continuing the pagination of
    /// the results started in a
    /// previous List Jobs request.
    marker: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_list = "JobList",
        .marker = "Marker",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListJobsInput, options: CallOptions) !ListJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "glacier", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("glacier", "Glacier", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.account_id);
    try path_buf.appendSlice(allocator, "/vaults/");
    try path_buf.appendSlice(allocator, input.vault_name);
    try path_buf.appendSlice(allocator, "/jobs");
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.completed) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "completed=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.limit) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "limit=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.marker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "marker=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.statuscode) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "statuscode=");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListJobsOutput {
    const result: ListJobsOutput = try aws.json.parseJsonObject(
        ListJobsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
