const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DomainVerificationMethod = @import("domain_verification_method.zig").DomainVerificationMethod;
const VerificationDetails = @import("verification_details.zig").VerificationDetails;
const TargetDomainStatus = @import("target_domain_status.zig").TargetDomainStatus;

pub const CreateTargetDomainInput = struct {
    /// The tags to associate with the target domain.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The domain name to register as a target domain.
    target_domain_name: []const u8,

    /// The method to use for verifying domain ownership. Valid values are DNS_TXT,
    /// HTTP_ROUTE, and PRIVATE_VPC.
    verification_method: DomainVerificationMethod,

    pub const json_field_names = .{
        .tags = "tags",
        .target_domain_name = "targetDomainName",
        .verification_method = "verificationMethod",
    };
};

pub const CreateTargetDomainOutput = struct {
    /// The date and time the target domain was created, in UTC format.
    created_at: ?i64 = null,

    /// The domain name of the target domain.
    domain_name: []const u8,

    /// The unique identifier of the created target domain.
    target_domain_id: []const u8,

    /// The verification details for the target domain, including the verification
    /// token and instructions.
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

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateTargetDomainInput, options: CallOptions) !CreateTargetDomainOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateTargetDomainInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityagent", "SecurityAgent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/CreateTargetDomain";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"targetDomainName\":");
    try aws.json.writeValue(@TypeOf(input.target_domain_name), input.target_domain_name, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateTargetDomainOutput {
    const result: CreateTargetDomainOutput = try aws.json.parseJsonObject(
        CreateTargetDomainOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
