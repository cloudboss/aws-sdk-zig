const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const SignPayloadInput = struct {
    /// Specifies the object digest (hash) to sign.
    payload: []const u8,

    /// Payload content type. The single valid type is
    /// `application/vnd.cncf.notary.payload.v1+json`.
    payload_format: []const u8,

    /// The name of the signing profile.
    profile_name: []const u8,

    /// The AWS account ID of the profile owner.
    profile_owner: ?[]const u8 = null,

    pub const json_field_names = .{
        .payload = "payload",
        .payload_format = "payloadFormat",
        .profile_name = "profileName",
        .profile_owner = "profileOwner",
    };
};

pub const SignPayloadOutput = struct {
    /// Unique identifier of the signing job.
    job_id: ?[]const u8 = null,

    /// The AWS account ID of the job owner.
    job_owner: ?[]const u8 = null,

    /// Information including the signing profile ARN and the signing job ID.
    metadata: ?[]const aws.map.StringMapEntry = null,

    /// A cryptographic signature.
    signature: ?[]const u8 = null,

    pub const json_field_names = .{
        .job_id = "jobId",
        .job_owner = "jobOwner",
        .metadata = "metadata",
        .signature = "signature",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: SignPayloadInput, options: CallOptions) !SignPayloadOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: SignPayloadInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("signer", "signer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/signing-jobs/with-payload";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"payload\":");
    try aws.json.writeValue(@TypeOf(input.payload), input.payload, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"payloadFormat\":");
    try aws.json.writeValue(@TypeOf(input.payload_format), input.payload_format, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !SignPayloadOutput {
    const result: SignPayloadOutput = try aws.json.parseJsonObject(
        SignPayloadOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
