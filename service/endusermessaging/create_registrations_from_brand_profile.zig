const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const JobResult = @import("job_result.zig").JobResult;

pub const CreateRegistrationsFromBrandProfileInput = struct {
    /// The unique identifier of the brand profile. You can specify either the bare
    /// ID or the full Amazon Resource Name (ARN).
    brand_profile_id: []const u8,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If you do not specify a client token, the AWS
    /// SDK automatically generates one.
    client_token: ?[]const u8 = null,

    /// The registration types to create, for example US_TOLL_FREE_REGISTRATION or
    /// SENDER_ID.
    registration_types: []const []const u8,

    /// Specifies whether to use semantic field mapping between brand profile
    /// attributes and registration fields. The default is true. When false, the
    /// service maps fields using a fixed set of standard field types.
    smart_match: ?bool = null,

    pub const json_field_names = .{
        .brand_profile_id = "brandProfileId",
        .client_token = "clientToken",
        .registration_types = "registrationTypes",
        .smart_match = "smartMatch",
    };
};

pub const CreateRegistrationsFromBrandProfileOutput = struct {
    /// The results of the operation. Each result pairs a requested item with the
    /// asynchronous job that processes it.
    results: ?[]const JobResult = null,

    pub const json_field_names = .{
        .results = "results",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateRegistrationsFromBrandProfileInput, options: CallOptions) !CreateRegistrationsFromBrandProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "end-user-messaging", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateRegistrationsFromBrandProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("end-user-messaging", "EndUserMessaging", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/v1/brand-profiles/");
    try path_buf.appendSlice(allocator, input.brand_profile_id);
    try path_buf.appendSlice(allocator, "/create-registrations");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"registrationTypes\":");
    try aws.json.writeValue(@TypeOf(input.registration_types), input.registration_types, allocator, &body_buf);
    has_prev = true;
    if (input.smart_match) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"smartMatch\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateRegistrationsFromBrandProfileOutput {
    const result: CreateRegistrationsFromBrandProfileOutput = try aws.json.parseJsonObject(
        CreateRegistrationsFromBrandProfileOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
