const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Distribution = @import("distribution.zig").Distribution;
const serde = @import("serde.zig");

pub const CopyDistributionInput = struct {
    /// A value that uniquely identifies a request to create a resource. This helps
    /// to prevent CloudFront from creating a duplicate resource if you accidentally
    /// resubmit an identical request.
    caller_reference: []const u8,

    /// A Boolean flag to specify the state of the staging distribution when it's
    /// created. When you set this value to `True`, the staging distribution is
    /// enabled. When you set this value to `False`, the staging distribution is
    /// disabled.
    ///
    /// If you omit this field, the default value is `True`.
    enabled: ?bool = null,

    /// The version identifier of the primary distribution whose configuration you
    /// are copying. This is the `ETag` value returned in the response to
    /// `GetDistribution` and `GetDistributionConfig`.
    if_match: ?[]const u8 = null,

    /// The identifier of the primary distribution whose configuration you are
    /// copying. To get a distribution ID, use `ListDistributions`.
    primary_distribution_id: []const u8,

    /// The type of distribution that your primary distribution will be copied to.
    /// The only valid value is `True`, indicating that you are copying to a staging
    /// distribution.
    staging: ?bool = null,
};

pub const CopyDistributionOutput = struct {
    distribution: ?Distribution = null,

    /// The version identifier for the current version of the staging distribution.
    e_tag: ?[]const u8 = null,

    /// The URL of the staging distribution.
    location: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CopyDistributionInput, options: CallOptions) !CopyDistributionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "cloudfront", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CopyDistributionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("cloudfront", "CloudFront", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/2020-05-31/distribution/");
    try path_buf.appendSlice(allocator, input.primary_distribution_id);
    try path_buf.appendSlice(allocator, "/copy");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    try body_buf.appendSlice(allocator, "<CopyDistributionRequest xmlns=\"http://cloudfront.amazonaws.com/doc/2020-05-31/\">");
    try body_buf.appendSlice(allocator, "<CallerReference>");
    try aws.xml.appendXmlEscaped(allocator, &body_buf, input.caller_reference);
    try body_buf.appendSlice(allocator, "</CallerReference>");
    if (input.enabled) |v| {
        try body_buf.appendSlice(allocator, "<Enabled>");
        try body_buf.appendSlice(allocator, if (v) "true" else "false");
        try body_buf.appendSlice(allocator, "</Enabled>");
    }
    try body_buf.appendSlice(allocator, "</CopyDistributionRequest>");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/xml");
    if (input.if_match) |v| {
        try request.headers.put(allocator, "If-Match", v);
    }
    if (input.staging) |v| {
        try request.headers.put(allocator, "Staging", if (v) "true" else "false");
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CopyDistributionOutput {
    var result: CopyDistributionOutput = .{};
    _ = status;
    _ = body;
    if (headers.get("etag")) |value| {
        result.e_tag = try allocator.dupe(u8, value);
    }
    if (headers.get("location")) |value| {
        result.location = try allocator.dupe(u8, value);
    }

    return result;
}
