const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PricingPlan = @import("pricing_plan.zig").PricingPlan;

pub const DescribeGeofenceCollectionInput = struct {
    /// The name of the geofence collection.
    collection_name: []const u8,

    pub const json_field_names = .{
        .collection_name = "CollectionName",
    };
};

pub const DescribeGeofenceCollectionOutput = struct {
    /// The Amazon Resource Name (ARN) for the geofence collection resource. Used
    /// when you need to specify a resource across all Amazon Web Services.
    ///
    /// * Format example:
    ///   `arn:aws:geo:region:account-id:geofence-collection/ExampleGeofenceCollection`
    collection_arn: []const u8,

    /// The name of the geofence collection.
    collection_name: []const u8,

    /// The timestamp for when the geofence resource was created in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`
    create_time: i64,

    /// The optional description for the geofence collection.
    description: []const u8,

    /// The number of geofences in the geofence collection.
    geofence_count: ?i32 = null,

    /// A key identifier for an [Amazon Web Services KMS customer managed
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/create-keys.html)
    /// assigned to the Amazon Location resource
    kms_key_id: ?[]const u8 = null,

    /// No longer used. Always returns `RequestBasedUsage`.
    pricing_plan: ?PricingPlan = null,

    /// No longer used. Always returns an empty string.
    pricing_plan_data_source: ?[]const u8 = null,

    /// Displays the key, value pairs of tags associated with this resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp for when the geofence collection was last updated in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`
    update_time: i64,

    pub const json_field_names = .{
        .collection_arn = "CollectionArn",
        .collection_name = "CollectionName",
        .create_time = "CreateTime",
        .description = "Description",
        .geofence_count = "GeofenceCount",
        .kms_key_id = "KmsKeyId",
        .pricing_plan = "PricingPlan",
        .pricing_plan_data_source = "PricingPlanDataSource",
        .tags = "Tags",
        .update_time = "UpdateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeGeofenceCollectionInput, options: CallOptions) !DescribeGeofenceCollectionOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "geo", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeGeofenceCollectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo", "Location", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/geofencing/v0/collections/");
    try path_buf.appendSlice(allocator, input.collection_name);
    const path = try path_buf.toOwnedSlice(allocator);

    const body: ?[]const u8 = null;

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeGeofenceCollectionOutput {
    const result: DescribeGeofenceCollectionOutput = try aws.json.parseJsonObject(
        DescribeGeofenceCollectionOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
