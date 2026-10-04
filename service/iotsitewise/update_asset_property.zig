const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const PropertyNotificationState = @import("property_notification_state.zig").PropertyNotificationState;

pub const UpdateAssetPropertyInput = struct {
    /// The ID of the asset to be updated. This can be either the actual ID in UUID
    /// format, or else `externalId:` followed by the external ID, if it has one.
    /// For more information, see [Referencing objects with external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-id-references) in the *IoT SiteWise User Guide*.
    asset_id: []const u8,

    /// A unique case-sensitive identifier that you can provide to ensure the
    /// idempotency of the request. Don't reuse this client token if a new
    /// idempotent request is required.
    client_token: ?[]const u8 = null,

    /// The alias that identifies the property, such as an OPC-UA server data stream
    /// path
    /// (for example, `/company/windfarm/3/turbine/7/temperature`). For more
    /// information, see
    /// [Mapping industrial data streams to asset
    /// properties](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/connect-data-streams.html) in the
    /// *IoT SiteWise User Guide*.
    ///
    /// If you omit this parameter, the alias is removed from the property.
    property_alias: ?[]const u8 = null,

    /// The ID of the asset property to be updated. This can be either the actual ID
    /// in UUID format, or else `externalId:` followed by the external ID, if it has
    /// one.
    /// For more information, see [Referencing objects with external
    /// IDs](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/object-ids.html#external-id-references) in the *IoT SiteWise User Guide*.
    property_id: []const u8,

    /// The MQTT notification state (enabled or disabled) for this asset property.
    /// When the notification state is enabled, IoT SiteWise publishes property
    /// value
    /// updates to a unique MQTT topic. For more information, see [Interacting with
    /// other
    /// services](https://docs.aws.amazon.com/iot-sitewise/latest/userguide/interact-with-other-services.html) in the *IoT SiteWise User Guide*.
    ///
    /// If you omit this parameter, the notification state is set to `DISABLED`.
    property_notification_state: ?PropertyNotificationState = null,

    /// The unit of measure (such as Newtons or RPM) of the asset property. If you
    /// don't specify a
    /// value for this parameter, the service uses the value of the
    /// `assetModelProperty` in
    /// the asset model.
    property_unit: ?[]const u8 = null,

    pub const json_field_names = .{
        .asset_id = "assetId",
        .client_token = "clientToken",
        .property_alias = "propertyAlias",
        .property_id = "propertyId",
        .property_notification_state = "propertyNotificationState",
        .property_unit = "propertyUnit",
    };
};

pub const UpdateAssetPropertyOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateAssetPropertyInput, options: CallOptions) !UpdateAssetPropertyOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotsitewise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateAssetPropertyInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotsitewise", "IoTSiteWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/assets/");
    try path_buf.appendSlice(allocator, input.asset_id);
    try path_buf.appendSlice(allocator, "/properties/");
    try path_buf.appendSlice(allocator, input.property_id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"clientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.property_alias) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"propertyAlias\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.property_notification_state) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"propertyNotificationState\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.property_unit) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"propertyUnit\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateAssetPropertyOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateAssetPropertyOutput = .{};

    return result;
}
