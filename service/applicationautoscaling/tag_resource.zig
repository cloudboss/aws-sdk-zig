const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const TagResourceInput = struct {
    /// Identifies the Application Auto Scaling scalable target that you want to
    /// apply tags to.
    ///
    /// For example:
    /// `arn:aws:application-autoscaling:us-east-1:123456789012:scalable-target/1234abcd56ab78cd901ef1234567890ab123`
    ///
    /// To get the ARN for a scalable target, use DescribeScalableTargets.
    resource_arn: []const u8,

    /// The tags assigned to the resource. A tag is a label that you assign to an
    /// Amazon Web Services
    /// resource.
    ///
    /// Each tag consists of a tag key and a tag value.
    ///
    /// You cannot have more than one tag on an Application Auto Scaling scalable
    /// target with the same tag key.
    /// If you specify an existing tag key with a different tag value, Application
    /// Auto Scaling replaces the
    /// current tag value with the specified one.
    ///
    /// For information about the rules that apply to tag keys and tag values, see
    /// [User-defined tag
    /// restrictions](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/allocation-tag-restrictions.html) in the *Amazon Web Services Billing User Guide*.
    tags: []const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .resource_arn = "ResourceARN",
        .tags = "Tags",
    };
};

pub const TagResourceOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: TagResourceInput, options: CallOptions) !TagResourceOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "application-autoscaling", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: TagResourceInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("application-autoscaling", "Application Auto Scaling", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AnyScaleFrontendService.TagResource");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !TagResourceOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
