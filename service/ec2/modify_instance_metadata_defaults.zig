const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const DefaultInstanceMetadataEndpointState = @import("default_instance_metadata_endpoint_state.zig").DefaultInstanceMetadataEndpointState;
const MetadataDefaultHttpTokensState = @import("metadata_default_http_tokens_state.zig").MetadataDefaultHttpTokensState;
const DefaultHttpTokensEnforcedState = @import("default_http_tokens_enforced_state.zig").DefaultHttpTokensEnforcedState;
const DefaultInstanceMetadataTagsState = @import("default_instance_metadata_tags_state.zig").DefaultInstanceMetadataTagsState;

pub const ModifyInstanceMetadataDefaultsInput = struct {
    /// Checks whether you have the required permissions for the operation, without
    /// actually making the
    /// request, and provides an error response. If you have the required
    /// permissions, the error response is
    /// `DryRunOperation`. Otherwise, it is `UnauthorizedOperation`.
    dry_run: ?bool = null,

    /// Enables or disables the IMDS endpoint on an instance. When disabled, the
    /// instance
    /// metadata can't be accessed.
    http_endpoint: ?DefaultInstanceMetadataEndpointState = null,

    /// The maximum number of hops that the metadata token can travel. To indicate
    /// no
    /// preference, specify `-1`.
    ///
    /// Possible values: Integers from `1` to `64`, and `-1`
    /// to indicate no preference
    http_put_response_hop_limit: ?i32 = null,

    /// Indicates whether IMDSv2 is required.
    ///
    /// * `optional` – IMDSv2 is optional, which means that you can
    /// use either IMDSv2 or IMDSv1.
    ///
    /// * `required` – IMDSv2 is required, which means that IMDSv1 is
    /// disabled, and you must use IMDSv2.
    http_tokens: ?MetadataDefaultHttpTokensState = null,

    /// Specifies whether to enforce the requirement of IMDSv2 on an instance at the
    /// time of
    /// launch. When enforcement is enabled, the instance can't launch unless IMDSv2
    /// (`HttpTokens`) is set to `required`. For more information, see
    /// [Enforce IMDSv2 at the account
    /// level](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-IMDS-new-instances.html#enforce-imdsv2-at-the-account-level) in the
    /// *Amazon EC2 User Guide*.
    http_tokens_enforced: ?DefaultHttpTokensEnforcedState = null,

    /// Enables or disables access to an instance's tags from the instance metadata.
    /// For more
    /// information, see [View tags for your EC2
    /// instances using instance
    /// metadata](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/work-with-tags-in-IMDS.html) in the
    /// *Amazon EC2 User Guide*.
    instance_metadata_tags: ?DefaultInstanceMetadataTagsState = null,
};

pub const ModifyInstanceMetadataDefaultsOutput = struct {
    /// If the request succeeds, the response returns `true`. If the request fails,
    /// no response is returned, and instead an error message is returned.
    @"return": ?bool = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyInstanceMetadataDefaultsInput, options: CallOptions) !ModifyInstanceMetadataDefaultsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "ec2");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyInstanceMetadataDefaultsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(allocator, "Action=ModifyInstanceMetadataDefaults&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.http_endpoint) |v| {
        try body_buf.appendSlice(allocator, "&HttpEndpoint=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.http_put_response_hop_limit) |v| {
        try body_buf.appendSlice(allocator, "&HttpPutResponseHopLimit=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, std.fmt.allocPrint(allocator, "{d}", .{v}) catch "");
    }
    if (input.http_tokens) |v| {
        try body_buf.appendSlice(allocator, "&HttpTokens=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.http_tokens_enforced) |v| {
        try body_buf.appendSlice(allocator, "&HttpTokensEnforced=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.instance_metadata_tags) |v| {
        try body_buf.appendSlice(allocator, "&InstanceMetadataTags=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyInstanceMetadataDefaultsOutput {
    _ = status;
    _ = headers;
    _ = allocator;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var result: ModifyInstanceMetadataDefaultsOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "return")) {
                    result.@"return" = std.mem.eql(u8, try reader.readElementText(), "true");
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

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = aws.xml.findElement(body, "Code") orelse "Unknown";
    const error_message = aws.xml.findElement(body, "Message") orelse "";
    const request_id = aws.xml.findElement(body, "RequestID") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, request_id);


    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
