const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RecommendationPreferenceName = @import("recommendation_preference_name.zig").RecommendationPreferenceName;
const ResourceType = @import("resource_type.zig").ResourceType;
const Scope = @import("scope.zig").Scope;

pub const DeleteRecommendationPreferencesInput = struct {
    /// The name of the recommendation preference to delete.
    recommendation_preference_names: []const RecommendationPreferenceName,

    /// The target resource type of the recommendation preference to delete.
    ///
    /// The `Ec2Instance` option encompasses standalone instances and instances
    /// that are part of Auto Scaling groups. The `AutoScalingGroup` option
    /// encompasses only instances that are part of an Auto Scaling group.
    resource_type: ResourceType,

    /// An object that describes the scope of the recommendation preference to
    /// delete.
    ///
    /// You can delete recommendation preferences that are created at the
    /// organization level
    /// (for management accounts of an organization only), account level, and
    /// resource level.
    /// For more information, see [Activating
    /// enhanced infrastructure
    /// metrics](https://docs.aws.amazon.com/compute-optimizer/latest/ug/enhanced-infrastructure-metrics.html) in the *Compute Optimizer User
    /// Guide*.
    scope: ?Scope = null,

    pub const json_field_names = .{
        .recommendation_preference_names = "recommendationPreferenceNames",
        .resource_type = "resourceType",
        .scope = "scope",
    };
};

pub const DeleteRecommendationPreferencesOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DeleteRecommendationPreferencesInput, options: CallOptions) !DeleteRecommendationPreferencesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "compute-optimizer", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DeleteRecommendationPreferencesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("compute-optimizer", "Compute Optimizer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "ComputeOptimizerService.DeleteRecommendationPreferences");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DeleteRecommendationPreferencesOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
