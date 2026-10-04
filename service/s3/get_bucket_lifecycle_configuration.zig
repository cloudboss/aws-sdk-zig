const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LifecycleRule = @import("lifecycle_rule.zig").LifecycleRule;
const TransitionDefaultMinimumObjectSize = @import("transition_default_minimum_object_size.zig").TransitionDefaultMinimumObjectSize;
const serde = @import("serde.zig");

pub const GetBucketLifecycleConfigurationInput = struct {
    /// The name of the bucket for which to get the lifecycle information.
    bucket: []const u8,

    /// The account ID of the expected bucket owner. If the account ID that you
    /// provide does not match the actual owner of the bucket, the request fails
    /// with the HTTP status code `403 Forbidden` (access denied).
    ///
    /// This parameter applies to general purpose buckets only. It is not supported
    /// for directory bucket
    /// lifecycle configurations.
    expected_bucket_owner: ?[]const u8 = null,
};

pub const GetBucketLifecycleConfigurationOutput = struct {
    /// Container for a lifecycle rule.
    rules: ?[]const LifecycleRule = null,

    /// Indicates which default minimum object size behavior is applied to the
    /// lifecycle
    /// configuration.
    ///
    /// This parameter applies to general purpose buckets only. It isn't supported
    /// for directory bucket
    /// lifecycle configurations.
    ///
    /// * `all_storage_classes_128K` - Objects smaller than 128 KB will not
    ///   transition to
    /// any storage class by default.
    ///
    /// * `varies_by_storage_class` - Objects smaller than 128 KB will transition to
    ///   Glacier
    /// Flexible Retrieval or Glacier Deep Archive storage classes. By default, all
    /// other storage classes
    /// will prevent transitions smaller than 128 KB.
    ///
    /// To customize the minimum object size for any transition you can add a filter
    /// that specifies a custom
    /// `ObjectSizeGreaterThan` or `ObjectSizeLessThan` in the body of your
    /// transition
    /// rule. Custom filters always take precedence over the default transition
    /// behavior.
    transition_default_minimum_object_size: ?TransitionDefaultMinimumObjectSize = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetBucketLifecycleConfigurationInput, options: CallOptions) !GetBucketLifecycleConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "s3", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetBucketLifecycleConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("s3", "S3", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/");
    try path_buf.appendSlice(allocator, input.bucket);
    const path = try path_buf.toOwnedSlice(allocator);

    var query_buf: std.ArrayList(u8) = .empty;
    var query_has_prev = false;
    try query_buf.appendSlice(allocator, "lifecycle");
    query_has_prev = true;
    const query = try query_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    request.query = query;
    if (input.expected_bucket_owner) |v| {
        try request.headers.put(allocator, "x-amz-expected-bucket-owner", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetBucketLifecycleConfigurationOutput {
    var result: GetBucketLifecycleConfigurationOutput = .{};
    _ = status;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => break,
            else => {},
        }
    }

    var rules_list: std.ArrayList(LifecycleRule) = .empty;
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Rule")) {
                    try rules_list.append(allocator, try serde.deserializeLifecycleRule(allocator, &reader));
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }
    result.rules = if (rules_list.items.len > 0) try rules_list.toOwnedSlice(allocator) else null;
    if (headers.get("x-amz-transition-default-minimum-object-size")) |value| {
        result.transition_default_minimum_object_size = TransitionDefaultMinimumObjectSize.fromWireName(value);
    }

    return result;
}
