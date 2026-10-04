const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProvisioningType = @import("provisioning_type.zig").ProvisioningType;
const ProvisioningProfileStatus = @import("provisioning_profile_status.zig").ProvisioningProfileStatus;

pub const CreateProvisioningProfileInput = struct {
    /// The body of the PEM-encoded certificate authority (CA) certificate.
    ca_certificate: ?[]const u8 = null,

    /// The body of the PEM-encoded claim certificate. If a claim certificate is
    /// provided, it will be used for the provisioning profile. Otherwise, a claim
    /// certificate will be generated.
    claim_certificate: ?[]const u8 = null,

    /// An idempotency token. If you retry a request that completed successfully
    /// initially using the same client token and parameters, then the retry attempt
    /// will succeed without performing any further actions.
    client_token: ?[]const u8 = null,

    /// The name of the provisioning profile.
    name: ?[]const u8 = null,

    /// The type of provisioning workflow the device uses for onboarding to IoT
    /// managed integrations.
    provisioning_type: ProvisioningType,

    /// A set of key/value pairs that are used to manage the provisioning profile.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .ca_certificate = "CaCertificate",
        .claim_certificate = "ClaimCertificate",
        .client_token = "ClientToken",
        .name = "Name",
        .provisioning_type = "ProvisioningType",
        .tags = "Tags",
    };
};

pub const CreateProvisioningProfileOutput = struct {
    /// The Amazon Resource Name (ARN) of the provisioning profile.
    arn: ?[]const u8 = null,

    /// The body of the PEM-encoded claim certificate.
    claim_certificate: ?[]const u8 = null,

    /// The private key of the claim certificate. This may be stored securely on the
    /// device for validating the connection endpoint with IoT managed integrations
    /// using the public key.
    claim_certificate_private_key: ?[]const u8 = null,

    /// The identifier of the provisioning profile.
    id: ?[]const u8 = null,

    /// The name of the provisioning profile.
    name: ?[]const u8 = null,

    /// The type of provisioning workflow the device uses for onboarding to IoT
    /// managed integrations.
    provisioning_type: ?ProvisioningType = null,

    /// The status of a provisioning profile.
    status: ?ProvisioningProfileStatus = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .claim_certificate = "ClaimCertificate",
        .claim_certificate_private_key = "ClaimCertificatePrivateKey",
        .id = "Id",
        .name = "Name",
        .provisioning_type = "ProvisioningType",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateProvisioningProfileInput, options: CallOptions) !CreateProvisioningProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotmanagedintegrations", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateProvisioningProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("api.iotmanagedintegrations", "IoT Managed Integrations", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/provisioning-profiles";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.ca_certificate) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"CaCertificate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.claim_certificate) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClaimCertificate\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.name) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Name\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"ProvisioningType\":");
    try aws.json.writeValue(@TypeOf(input.provisioning_type), input.provisioning_type, allocator, &body_buf);
    has_prev = true;
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateProvisioningProfileOutput {
    const result: CreateProvisioningProfileOutput = try aws.json.parseJsonObject(
        CreateProvisioningProfileOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
