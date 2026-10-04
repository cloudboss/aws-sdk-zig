const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSourceConfiguration = @import("data_source_configuration.zig").DataSourceConfiguration;
const PricingPlan = @import("pricing_plan.zig").PricingPlan;

pub const UpdatePlaceIndexInput = struct {
    /// Updates the data storage option for the place index resource.
    data_source_configuration: ?DataSourceConfiguration = null,

    /// Updates the description for the place index resource.
    description: ?[]const u8 = null,

    /// The name of the place index resource to update.
    index_name: []const u8,

    /// No longer used. If included, the only allowed value is `RequestBasedUsage`.
    pricing_plan: ?PricingPlan = null,

    pub const json_field_names = .{
        .data_source_configuration = "DataSourceConfiguration",
        .description = "Description",
        .index_name = "IndexName",
        .pricing_plan = "PricingPlan",
    };
};

pub const UpdatePlaceIndexOutput = struct {
    /// The Amazon Resource Name (ARN) of the upated place index resource. Used to
    /// specify a resource across Amazon Web Services.
    ///
    /// * Format example: `arn:aws:geo:region:account-id:place-
    ///   index/ExamplePlaceIndex`
    index_arn: []const u8,

    /// The name of the updated place index resource.
    index_name: []const u8,

    /// The timestamp for when the place index resource was last updated in [ ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    update_time: i64,

    pub const json_field_names = .{
        .index_arn = "IndexArn",
        .index_name = "IndexName",
        .update_time = "UpdateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdatePlaceIndexInput, options: CallOptions) !UpdatePlaceIndexOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdatePlaceIndexInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo", "Location", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/places/v0/indexes/");
    try path_buf.appendSlice(allocator, input.index_name);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.data_source_configuration) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DataSourceConfiguration\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.pricing_plan) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"PricingPlan\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PATCH;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdatePlaceIndexOutput {
    var result: UpdatePlaceIndexOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdatePlaceIndexOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
