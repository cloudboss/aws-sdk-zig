const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PricingPlan = @import("pricing_plan.zig").PricingPlan;

pub const CreateGeofenceCollectionInput = struct {
    /// A custom name for the geofence collection.
    ///
    /// Requirements:
    ///
    /// * Contain only alphanumeric characters (A–Z, a–z, 0–9), hyphens (-), periods
    ///   (.), and underscores (_).
    /// * Must be a unique geofence collection name.
    /// * No spaces allowed. For example, `ExampleGeofenceCollection`.
    collection_name: []const u8,

    /// An optional description for the geofence collection.
    description: ?[]const u8 = null,

    /// A key identifier for an [Amazon Web Services KMS customer managed
    /// key](https://docs.aws.amazon.com/kms/latest/developerguide/create-keys.html). Enter a key ID, key ARN, alias name, or alias ARN.
    kms_key_id: ?[]const u8 = null,

    /// No longer used. If included, the only allowed value is `RequestBasedUsage`.
    pricing_plan: ?PricingPlan = null,

    /// This parameter is no longer used.
    pricing_plan_data_source: ?[]const u8 = null,

    /// Applies one or more tags to the geofence collection. A tag is a key-value
    /// pair helps manage, identify, search, and filter your resources by labelling
    /// them.
    ///
    /// Format: `"key" : "value"`
    ///
    /// Restrictions:
    ///
    /// * Maximum 50 tags per resource
    /// * Each resource tag must be unique with a maximum of one value.
    /// * Maximum key length: 128 Unicode characters in UTF-8
    /// * Maximum value length: 256 Unicode characters in UTF-8
    /// * Can use alphanumeric characters (A–Z, a–z, 0–9), and the following
    ///   characters: + - = . _ : / @.
    /// * Cannot use "aws:" as a prefix for a key.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .collection_name = "CollectionName",
        .description = "Description",
        .kms_key_id = "KmsKeyId",
        .pricing_plan = "PricingPlan",
        .pricing_plan_data_source = "PricingPlanDataSource",
        .tags = "Tags",
    };
};

pub const CreateGeofenceCollectionOutput = struct {
    /// The Amazon Resource Name (ARN) for the geofence collection resource. Used
    /// when you need to specify a resource across all Amazon Web Services.
    ///
    /// * Format example:
    ///   `arn:aws:geo:region:account-id:geofence-collection/ExampleGeofenceCollection`
    collection_arn: []const u8,

    /// The name for the geofence collection.
    collection_name: []const u8,

    /// The timestamp for when the geofence collection was created in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`
    create_time: i64,

    pub const json_field_names = .{
        .collection_arn = "CollectionArn",
        .collection_name = "CollectionName",
        .create_time = "CreateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateGeofenceCollectionInput, options: CallOptions) !CreateGeofenceCollectionOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateGeofenceCollectionInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo", "Location", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/geofencing/v0/collections";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"CollectionName\":");
    try aws.json.writeValue(@TypeOf(input.collection_name), input.collection_name, allocator, &body_buf);
    has_prev = true;
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.kms_key_id) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"KmsKeyId\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.pricing_plan) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PricingPlan\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.pricing_plan_data_source) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PricingPlanDataSource\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.tags) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Tags\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateGeofenceCollectionOutput {
    var result: CreateGeofenceCollectionOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateGeofenceCollectionOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
