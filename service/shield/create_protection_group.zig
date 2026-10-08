const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ProtectionGroupAggregation = @import("protection_group_aggregation.zig").ProtectionGroupAggregation;
const ProtectionGroupPattern = @import("protection_group_pattern.zig").ProtectionGroupPattern;
const ProtectedResourceType = @import("protected_resource_type.zig").ProtectedResourceType;
const Tag = @import("tag.zig").Tag;

pub const CreateProtectionGroupInput = struct {
    /// Defines how Shield combines resource data for the group in order to detect,
    /// mitigate, and report events.
    ///
    /// * Sum - Use the total traffic across the group. This is a good choice for
    ///   most cases. Examples include Elastic IP addresses for EC2 instances that
    ///   scale manually or automatically.
    ///
    /// * Mean - Use the average of the traffic across the group. This is a good
    ///   choice for resources that share traffic uniformly. Examples include
    ///   accelerators and load balancers.
    ///
    /// * Max - Use the highest traffic from each resource. This is useful for
    ///   resources that don't share traffic and for resources that share that
    ///   traffic in a non-uniform way. Examples include Amazon CloudFront and
    ///   origin resources for CloudFront distributions.
    aggregation: ProtectionGroupAggregation,

    /// The Amazon Resource Names (ARNs) of the resources to include in the
    /// protection group. You must set this when you set `Pattern` to `ARBITRARY`
    /// and you must not set it for any other `Pattern` setting.
    members: ?[]const []const u8 = null,

    /// The criteria to use to choose the protected resources for inclusion in the
    /// group. You can include all resources that have protections, provide a list
    /// of resource Amazon Resource Names (ARNs), or include all resources of a
    /// specified resource type.
    pattern: ProtectionGroupPattern,

    /// The name of the protection group. You use this to identify the protection
    /// group in lists and to manage the protection group, for example to update,
    /// delete, or describe it.
    protection_group_id: []const u8,

    /// The resource type to include in the protection group. All protected
    /// resources of this type are included in the protection group. Newly protected
    /// resources of this type are automatically added to the group.
    /// You must set this when you set `Pattern` to `BY_RESOURCE_TYPE` and you must
    /// not set it for any other `Pattern` setting.
    resource_type: ?ProtectedResourceType = null,

    /// One or more tag key-value pairs for the protection group.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .aggregation = "Aggregation",
        .members = "Members",
        .pattern = "Pattern",
        .protection_group_id = "ProtectionGroupId",
        .resource_type = "ResourceType",
        .tags = "Tags",
    };
};

pub const CreateProtectionGroupOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateProtectionGroupInput, options: CallOptions) !CreateProtectionGroupOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateProtectionGroupInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AWSShield_20160616.CreateProtectionGroup");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateProtectionGroupOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
