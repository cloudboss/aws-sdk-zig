const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SigningPlatformOverrides = @import("signing_platform_overrides.zig").SigningPlatformOverrides;
const SigningProfileRevocationRecord = @import("signing_profile_revocation_record.zig").SigningProfileRevocationRecord;
const SignatureValidityPeriod = @import("signature_validity_period.zig").SignatureValidityPeriod;
const SigningMaterial = @import("signing_material.zig").SigningMaterial;
const SigningProfileStatus = @import("signing_profile_status.zig").SigningProfileStatus;

pub const GetSigningProfileInput = struct {
    /// The name of the target signing profile.
    profile_name: []const u8,

    /// The AWS account ID of the profile owner.
    profile_owner: ?[]const u8 = null,

    pub const json_field_names = .{
        .profile_name = "profileName",
        .profile_owner = "profileOwner",
    };
};

pub const GetSigningProfileOutput = struct {
    /// The Amazon Resource Name (ARN) for the signing profile.
    arn: ?[]const u8 = null,

    /// A list of overrides applied by the target signing profile for signing
    /// operations.
    overrides: ?SigningPlatformOverrides = null,

    /// A human-readable name for the signing platform associated with the signing
    /// profile.
    platform_display_name: ?[]const u8 = null,

    /// The ID of the platform that is used by the target signing profile.
    platform_id: ?[]const u8 = null,

    /// The name of the target signing profile.
    profile_name: ?[]const u8 = null,

    /// The current version of the signing profile.
    profile_version: ?[]const u8 = null,

    /// The signing profile ARN, including the profile version.
    profile_version_arn: ?[]const u8 = null,

    revocation_record: ?SigningProfileRevocationRecord = null,

    signature_validity_period: ?SignatureValidityPeriod = null,

    /// The ARN of the certificate that the target profile uses for signing
    /// operations.
    signing_material: ?SigningMaterial = null,

    /// A map of key-value pairs for signing operations that is attached to the
    /// target signing
    /// profile.
    signing_parameters: ?[]const aws.map.StringMapEntry = null,

    /// The status of the target signing profile.
    status: ?SigningProfileStatus = null,

    /// Reason for the status of the target signing profile.
    status_reason: ?[]const u8 = null,

    /// A list of tags associated with the signing profile.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .overrides = "overrides",
        .platform_display_name = "platformDisplayName",
        .platform_id = "platformId",
        .profile_name = "profileName",
        .profile_version = "profileVersion",
        .profile_version_arn = "profileVersionArn",
        .revocation_record = "revocationRecord",
        .signature_validity_period = "signatureValidityPeriod",
        .signing_material = "signingMaterial",
        .signing_parameters = "signingParameters",
        .status = "status",
        .status_reason = "statusReason",
        .tags = "tags",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSigningProfileInput, options: CallOptions) !GetSigningProfileOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSigningProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("signer", "signer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/signing-profiles/");
    try path_buf.appendSlice(allocator, input.profile_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    if (input.profile_owner) |v| {
        if (query_has_prev) try query_buf.appendSlice(allocator, "&");
        try query_buf.appendSlice(allocator, "profileOwner=");
        try aws.url.appendUrlEncoded(allocator, &query_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSigningProfileOutput {
    const result: GetSigningProfileOutput = try aws.json.parseJsonObject(
        GetSigningProfileOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
