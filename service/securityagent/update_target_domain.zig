const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DomainVerificationMethod = @import("domain_verification_method.zig").DomainVerificationMethod;
const VerificationDetails = @import("verification_details.zig").VerificationDetails;
const TargetDomainStatus = @import("target_domain_status.zig").TargetDomainStatus;

pub const UpdateTargetDomainInput = struct {
    /// The unique identifier of the target domain to update.
    target_domain_id: []const u8,

    /// The updated verification method for the target domain.
    verification_method: DomainVerificationMethod,

    pub const json_field_names = .{
        .target_domain_id = "targetDomainId",
        .verification_method = "verificationMethod",
    };
};

pub const UpdateTargetDomainOutput = struct {
    /// The date and time the target domain was created, in UTC format.
    created_at: ?i64 = null,

    /// The domain name of the target domain.
    domain_name: []const u8,

    /// The unique identifier of the target domain.
    target_domain_id: []const u8,

    /// The updated verification details for the target domain.
    verification_details: ?VerificationDetails = null,

    /// The current verification status of the target domain.
    verification_status: TargetDomainStatus,

    /// The reason for the current target domain verification status.
    verification_status_reason: ?[]const u8 = null,

    /// The date and time the target domain was verified, in UTC format.
    verified_at: ?i64 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .domain_name = "domainName",
        .target_domain_id = "targetDomainId",
        .verification_details = "verificationDetails",
        .verification_status = "verificationStatus",
        .verification_status_reason = "verificationStatusReason",
        .verified_at = "verifiedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateTargetDomainInput, options: CallOptions) !UpdateTargetDomainOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityagent", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateTargetDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityagent", "SecurityAgent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/UpdateTargetDomain";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targetDomainId\":");
    try aws.json.writeValue(@TypeOf(input.target_domain_id), input.target_domain_id, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"verificationMethod\":");
    try aws.json.writeValue(@TypeOf(input.verification_method), input.verification_method, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateTargetDomainOutput {
    const result: UpdateTargetDomainOutput = try aws.json.parseJsonObject(
        UpdateTargetDomainOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
