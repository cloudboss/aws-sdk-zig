const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DefaultInstanceMetadataEndpointState = @import("default_instance_metadata_endpoint_state.zig").DefaultInstanceMetadataEndpointState;
const MetadataDefaultHttpTokensState = @import("metadata_default_http_tokens_state.zig").MetadataDefaultHttpTokensState;
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

    /// Enables or disables access to an instance's tags from the instance metadata.
    /// For more
    /// information, see [Work with
    /// instance tags using the instance
    /// metadata](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/Using_Tags.html#work-with-tags-in-IMDS) in the
    /// *Amazon EC2 User Guide*.
    instance_metadata_tags: ?DefaultInstanceMetadataTagsState = null,
};

pub const ModifyInstanceMetadataDefaultsOutput = struct {
    /// If the request succeeds, the response returns `true`. If the request fails,
    /// no response is returned, and instead an error message is returned.
    @"return": ?bool = null,

    _arena: std.heap.ArenaAllocator = undefined,

    pub fn deinit(self: *ModifyInstanceMetadataDefaultsOutput) void {
        self._arena.deinit();
    }
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, input: ModifyInstanceMetadataDefaultsInput, options: Options) !ModifyInstanceMetadataDefaultsOutput {
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

fn serializeRequest(alloc: std.mem.Allocator, input: ModifyInstanceMetadataDefaultsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ec2", "EC2", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    var body_buf: std.ArrayList(u8) = .{};

    try body_buf.appendSlice(alloc, "Action=ModifyInstanceMetadataDefaults&Version=2016-11-15");
    if (input.dry_run) |v| {
        try body_buf.appendSlice(alloc, "&DryRun=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, if (v) "true" else "false");
    }
    if (input.http_endpoint) |v| {
        try body_buf.appendSlice(alloc, "&HttpEndpoint=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.http_put_response_hop_limit) |v| {
        try body_buf.appendSlice(alloc, "&HttpPutResponseHopLimit=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, std.fmt.allocPrint(alloc, "{d}", .{v}) catch "");
    }
    if (input.http_tokens) |v| {
        try body_buf.appendSlice(alloc, "&HttpTokens=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }
    if (input.instance_metadata_tags) |v| {
        try body_buf.appendSlice(alloc, "&InstanceMetadataTags=");
        try aws.url.appendUrlEncoded(alloc, &body_buf, @tagName(v));
    }

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

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !ModifyInstanceMetadataDefaultsOutput {
    _ = status;
    _ = headers;
    _ = alloc;
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
