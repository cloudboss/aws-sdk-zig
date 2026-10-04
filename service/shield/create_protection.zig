const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;

pub const CreateProtectionInput = struct {
    /// Friendly name for the `Protection` you are creating.
    name: []const u8,

    /// The ARN (Amazon Resource Name) of the resource to be protected.
    ///
    /// The ARN should be in one of the following formats:
    ///
    /// * For an Application Load Balancer:
    ///   `arn:aws:elasticloadbalancing:*region*:*account-id*:loadbalancer/app/*load-balancer-name*/*load-balancer-id*
    /// `
    ///
    /// * For an Elastic Load Balancer (Classic Load Balancer):
    ///   `arn:aws:elasticloadbalancing:*region*:*account-id*:loadbalancer/*load-balancer-name*
    /// `
    ///
    /// * For an Amazon CloudFront distribution:
    ///   `arn:aws:cloudfront::*account-id*:distribution/*distribution-id*
    /// `
    ///
    /// * For an Global Accelerator standard accelerator:
    ///   `arn:aws:globalaccelerator::*account-id*:accelerator/*accelerator-id*
    /// `
    ///
    /// * For Amazon Route 53: `arn:aws:route53:::hostedzone/*hosted-zone-id*
    /// `
    ///
    /// * For an Elastic IP address:
    ///   `arn:aws:ec2:*region*:*account-id*:eip-allocation/*allocation-id*
    /// `
    resource_arn: []const u8,

    /// One or more tag key-value pairs for the Protection object that is created.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .name = "Name",
        .resource_arn = "ResourceArn",
        .tags = "Tags",
    };
};

pub const CreateProtectionOutput = struct {
    /// The unique identifier (ID) for the Protection object that is created.
    protection_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .protection_id = "ProtectionId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateProtectionInput, options: CallOptions) !CreateProtectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "shield", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateProtectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("shield", "Shield", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSShield_20160616.CreateProtection");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateProtectionOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateProtectionOutput, body, allocator);
}
