const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Destination = @import("destination.zig").Destination;
const Source = @import("source.zig").Source;

pub const StartSigningJobInput = struct {
    /// String that identifies the signing request. All calls after the first that
    /// use this
    /// token return the same response as the first call.
    client_request_token: []const u8,

    /// The S3 bucket in which to save your signed object. The destination contains
    /// the name
    /// of your bucket and an optional prefix.
    destination: Destination,

    /// The name of the signing profile.
    profile_name: []const u8,

    /// The AWS account ID of the signing profile owner.
    profile_owner: ?[]const u8 = null,

    /// The S3 bucket that contains the object to sign or a BLOB that contains your
    /// raw
    /// code.
    source: Source,

    pub const json_field_names = .{
        .client_request_token = "clientRequestToken",
        .destination = "destination",
        .profile_name = "profileName",
        .profile_owner = "profileOwner",
        .source = "source",
    };
};

pub const StartSigningJobOutput = struct {
    /// The ID of your signing job.
    job_id: ?[]const u8 = null,

    /// The AWS account ID of the signing job owner.
    job_owner: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_id = "jobId",
        .job_owner = "jobOwner",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartSigningJobInput, options: CallOptions) !StartSigningJobOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: StartSigningJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("signer", "signer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/signing-jobs";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"clientRequestToken\":");
    try aws.json.writeValue(@TypeOf(input.client_request_token), input.client_request_token, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"destination\":");
    try aws.json.writeValue(@TypeOf(input.destination), input.destination, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"profileName\":");
    try aws.json.writeValue(@TypeOf(input.profile_name), input.profile_name, allocator, &body_buf);
    has_prev = true;
    if (input.profile_owner) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"profileOwner\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"source\":");
    try aws.json.writeValue(@TypeOf(input.source), input.source, allocator, &body_buf);
    has_prev = true;

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartSigningJobOutput {
    const result: StartSigningJobOutput = try aws.json.parseJsonObject(
        StartSigningJobOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
