const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SigningPlatformOverrides = @import("signing_platform_overrides.zig").SigningPlatformOverrides;
const SignatureValidityPeriod = @import("signature_validity_period.zig").SignatureValidityPeriod;
const SigningMaterial = @import("signing_material.zig").SigningMaterial;

pub const PutSigningProfileInput = struct {
    /// A subfield of `platform`. This specifies any different configuration
    /// options that you want to apply to the chosen platform (such as a different
    /// `hash-algorithm` or `signing-algorithm`).
    overrides: ?SigningPlatformOverrides = null,

    /// The ID of the signing platform to be created.
    platform_id: []const u8,

    /// The name of the signing profile to be created.
    profile_name: []const u8,

    /// The default validity period override for any signature generated using this
    /// signing
    /// profile. If unspecified, the default is 135 months.
    signature_validity_period: ?SignatureValidityPeriod = null,

    /// The AWS Certificate Manager certificate that will be used to sign code with
    /// the new signing
    /// profile.
    signing_material: ?SigningMaterial = null,

    /// Map of key-value pairs for signing. These can include any information that
    /// you want to
    /// use during signing.
    signing_parameters: ?[]const aws.map.StringMapEntry = null,

    /// Tags to be associated with the signing profile that is being created.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .overrides = "overrides",
        .platform_id = "platformId",
        .profile_name = "profileName",
        .signature_validity_period = "signatureValidityPeriod",
        .signing_material = "signingMaterial",
        .signing_parameters = "signingParameters",
        .tags = "tags",
    };
};

pub const PutSigningProfileOutput = struct {
    /// The Amazon Resource Name (ARN) of the signing profile created.
    arn: ?[]const u8 = null,

    /// The version of the signing profile being created.
    profile_version: ?[]const u8 = null,

    /// The signing profile ARN, including the profile version.
    profile_version_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .profile_version = "profileVersion",
        .profile_version_arn = "profileVersionArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutSigningProfileInput, options: CallOptions) !PutSigningProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: PutSigningProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("signer", "signer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/signing-profiles/");
    try path_buf.appendSlice(allocator, input.profile_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.overrides) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"overrides\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"platformId\":");
    try aws.json.writeValue(@TypeOf(input.platform_id), input.platform_id, allocator, &body_buf);
    has_prev = true;
    if (input.signature_validity_period) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"signatureValidityPeriod\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.signing_material) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"signingMaterial\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.signing_parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"signingParameters\":");
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
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutSigningProfileOutput {
    const result: PutSigningProfileOutput = try aws.json.parseJsonObject(
        PutSigningProfileOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
