const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Permit = @import("permit.zig").Permit;
const SigningKeyInfo = @import("signing_key_info.zig").SigningKeyInfo;
const SupportPermitStatus = @import("support_permit_status.zig").SupportPermitStatus;

pub const CreateSupportPermitInput = struct {
    /// A unique, case-sensitive identifier to ensure that the operation completes
    /// no more than one time. If this token matches a previous request, the service
    /// returns the existing permit without creating a duplicate.
    client_token: ?[]const u8 = null,

    /// A human-readable description of why this permit is being created. Maximum
    /// length of 1024 characters.
    description: ?[]const u8 = null,

    /// A customer-chosen name for the support permit. Must be between 1 and 256
    /// alphanumeric characters.
    name: []const u8,

    /// The permit definition specifying the actions, resources, and time-window
    /// conditions that the support operator is authorized to use.
    permit: Permit,

    /// The signing key information used to sign the permit. Must reference an AWS
    /// KMS key with key usage SIGN_VERIFY and key spec ECC_NIST_P384.
    signing_key_info: SigningKeyInfo,

    /// The display identifier of the AWS Support case associated with this permit.
    support_case_display_id: ?[]const u8 = null,

    /// The tags to associate with the support permit on creation.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "clientToken",
        .description = "description",
        .name = "name",
        .permit = "permit",
        .signing_key_info = "signingKeyInfo",
        .support_case_display_id = "supportCaseDisplayId",
        .tags = "tags",
    };
};

pub const CreateSupportPermitOutput = struct {
    /// The Amazon Resource Name (ARN) of the support permit.
    arn: []const u8,

    /// The timestamp when the permit was created.
    created_at: i64,

    /// The description of the support permit.
    description: ?[]const u8 = null,

    /// The name of the support permit.
    name: []const u8,

    /// The permit definition.
    permit: ?Permit = null,

    /// The signing key information for the permit.
    signing_key_info: ?SigningKeyInfo = null,

    /// The current status of the support permit.
    status: SupportPermitStatus,

    /// The display identifier of the support case associated with the permit.
    support_case_display_id: ?[]const u8 = null,

    /// The tags associated with the support permit.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .created_at = "createdAt",
        .description = "description",
        .name = "name",
        .permit = "permit",
        .signing_key_info = "signingKeyInfo",
        .status = "status",
        .support_case_display_id = "supportCaseDisplayId",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateSupportPermitInput, options: CallOptions) !CreateSupportPermitOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "supportauthz", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateSupportPermitInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("supportauthz", "SupportAuthZ", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/support-permits";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"name\":");
    try aws.json.writeValue(@TypeOf(input.name), input.name, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"permit\":");
    try aws.json.writeValue(@TypeOf(input.permit), input.permit, allocator, &body_buf);
    has_prev = true;
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"signingKeyInfo\":");
    try aws.json.writeValue(@TypeOf(input.signing_key_info), input.signing_key_info, allocator, &body_buf);
    has_prev = true;
    if (input.support_case_display_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"supportCaseDisplayId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateSupportPermitOutput {
    const result: CreateSupportPermitOutput = try aws.json.parseJsonObject(
        CreateSupportPermitOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
