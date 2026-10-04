const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SigningStatus = @import("signing_status.zig").SigningStatus;
const SigningJob = @import("signing_job.zig").SigningJob;

pub const ListSigningJobsInput = struct {
    /// Filters results to return only signing jobs with revoked signatures.
    is_revoked: ?bool = null,

    /// Filters results to return only signing jobs initiated by a specified IAM
    /// entity.
    job_invoker: ?[]const u8 = null,

    /// Specifies the maximum number of items to return in the response. Use this
    /// parameter
    /// when paginating results. If additional items exist beyond the number you
    /// specify, the
    /// `nextToken` element is set in the response. Use the
    /// `nextToken` value in a subsequent request to retrieve additional items.
    max_results: ?i32 = null,

    /// String for specifying the next set of paginated results to return. After you
    /// receive a
    /// response with truncated results, use this parameter in a subsequent request.
    /// Set it to
    /// the value of `nextToken` from the response that you just received.
    next_token: ?[]const u8 = null,

    /// The ID of microcontroller platform that you specified for the distribution
    /// of your
    /// code image.
    platform_id: ?[]const u8 = null,

    /// The IAM principal that requested the signing job.
    requested_by: ?[]const u8 = null,

    /// Filters results to return only signing jobs with signatures expiring after a
    /// specified
    /// timestamp.
    signature_expires_after: ?i64 = null,

    /// Filters results to return only signing jobs with signatures expiring before
    /// a
    /// specified timestamp.
    signature_expires_before: ?i64 = null,

    /// A status value with which to filter your results.
    status: ?SigningStatus = null,

    pub const json_field_names = .{
        .is_revoked = "isRevoked",
        .job_invoker = "jobInvoker",
        .max_results = "maxResults",
        .next_token = "nextToken",
        .platform_id = "platformId",
        .requested_by = "requestedBy",
        .signature_expires_after = "signatureExpiresAfter",
        .signature_expires_before = "signatureExpiresBefore",
        .status = "status",
    };
};

pub const ListSigningJobsOutput = struct {
    /// A list of your signing jobs.
    jobs: ?[]const SigningJob = null,

    /// String for specifying the next set of paginated results.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .jobs = "jobs",
        .next_token = "nextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListSigningJobsInput, options: CallOptions) !ListSigningJobsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "signer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListSigningJobsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("signer", "signer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/signing-jobs";

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.is_revoked) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "isRevoked=");
        try query_buf.appendSlice(allocator, if (v) "true" else "false");
        query_has_prev = true;
    }
    if (input.job_invoker) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "jobInvoker=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
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
    if (input.platform_id) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "platformId=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.requested_by) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "requestedBy=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
        query_has_prev = true;
    }
    if (input.signature_expires_after) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "signatureExpiresAfter=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
        query_has_prev = true;
    }
    if (input.signature_expires_before) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "signatureExpiresBefore=");
        {
            const num_str = std.fmt.allocPrint(allocator, "{d}", .{v}) catch "";
            try query_buf.appendSlice(allocator, num_str);
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListSigningJobsOutput {
    const result: ListSigningJobsOutput = try aws.json.parseJsonObject(
        ListSigningJobsOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
