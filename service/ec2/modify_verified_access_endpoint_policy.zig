const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const VerifiedAccessSseSpecificationRequest = @import("verified_access_sse_specification_request.zig").VerifiedAccessSseSpecificationRequest;
const VerifiedAccessSseSpecificationResponse = @import("verified_access_sse_specification_response.zig").VerifiedAccessSseSpecificationResponse;
const serde = @import("serde.zig");

/// Modifies the specified Amazon Web Services Verified Access endpoint policy.
pub const ModifyVerifiedAccessEndpointPolicyInput = struct {
    /// A unique, case-sensitive token that you provide to ensure idempotency of
    /// your
    /// modification request. For more information, see [Ensuring
    /// idempotency](https://docs.aws.amazon.com/ec2/latest/devguide/ec2-api-idempotency.html).
    client_token: ?[]const u8 = null,

    /// Checks whether you have the required permissions for the action, without
    /// actually making the request,
    /// and provides an error response. If you have the required permissions, the
    /// error response is `DryRunOperation`.
    /// Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// The Verified Access policy document.
    policy_document: ?[]const u8 = null,

    /// The status of the Verified Access policy.
    policy_enabled: ?bool = null,

    /// The options for server side encryption.
    sse_specification: ?VerifiedAccessSseSpecificationRequest = null,

    /// The ID of the Verified Access endpoint.
    verified_access_endpoint_id: []const u8,
};

pub const ModifyVerifiedAccessEndpointPolicyOutput = struct {
    /// The Verified Access policy document.
    policy_document: ?[]const u8 = null,

    /// The status of the Verified Access policy.
    policy_enabled: ?bool = null,

    /// The options in use for server side encryption.
    sse_specification: ?VerifiedAccessSseSpecificationResponse = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyVerifiedAccessEndpointPolicyOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyVerifiedAccessEndpointPolicyInput, options: Options) !ModifyVerifiedAccessEndpointPolicyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(response.body, response.status);
        }
        return error.ServiceError;
    }

    var resp_arena = std.heap.ArenaAllocator.init(client.allocator);
    errdefer resp_arena.deinit();
    var result = try deserializeResponse(response.body, response.status, response.headers, resp_arena.allocator());
    result._arena = resp_arena;
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyVerifiedAccessEndpointPolicyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpoint("ec2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyVerifiedAccessEndpointPolicy&Version=2016-11-15");
    if (input.client_token) |v| {
        try body_buf.appendSlice(alloc, "&ClientToken=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.policy_document) |v| {
        try body_buf.appendSlice(alloc, "&PolicyDocument=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, v);
    }
    if (input.policy_enabled) |v| {
        try body_buf.appendSlice(alloc, "&PolicyEnabled=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.sse_specification) |v| {
        if (v.customer_managed_key_enabled) |sv| {
            try body_buf.appendSlice(alloc, "&SseSpecification.CustomerManagedKeyEnabled=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, if (sv) "true" else "false");
        }
        if (v.kms_key_arn) |sv| {
            try body_buf.appendSlice(alloc, "&SseSpecification.KmsKeyArn=");
            try aws.url.appendUrlEncoded(alloc, &body_buf, sv);
        }
    }
    try body_buf.appendSlice(alloc, "&VerifiedAccessEndpointId=");
    try aws.url.appendUrlEncoded(alloc, &body_buf, input.verified_access_endpoint_id);

    const body = try body_buf.toOwnedSlice(alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyVerifiedAccessEndpointPolicyOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyVerifiedAccessEndpointPolicyOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "policyDocument")) {
                    result.policy_document = try alloc.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "policyEnabled")) {
                    result.policy_enabled = std.mem.eql(u8, try reader.readElementText(), "true");
                } else if (std.mem.eql(u8, e.local, "sseSpecification")) {
                    result.sse_specification = try serde.deserializeVerifiedAccessSseSpecificationResponse(&reader, alloc);
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}

fn parseErrorResponse(body: []const u8, status: u16) ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";


    return .{ .unknown = .{
        .code = error_code,
        .message = error_message,
        .request_id = request_id,
        .http_status = status,
    } };
}
