const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const MapConfiguration = @import("map_configuration.zig").MapConfiguration;
const PricingPlan = @import("pricing_plan.zig").PricingPlan;

pub const DescribeMapInput = struct {
    /// The name of the map resource.
    map_name: []const u8,

    pub const json_field_names = .{
        .map_name = "MapName",
    };
};

pub const DescribeMapOutput = struct {
    /// Specifies the map tile style selected from a partner data provider.
    configuration: ?MapConfiguration = null,

    /// The timestamp for when the map resource was created in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    create_time: i64,

    /// Specifies the data provider for the associated map tiles.
    data_source: []const u8,

    /// The optional description for the map resource.
    description: []const u8,

    /// The Amazon Resource Name (ARN) for the map resource. Used to specify a
    /// resource across all Amazon Web Services.
    ///
    /// * Format example: `arn:aws:geo:region:account-id:map/ExampleMap`
    map_arn: []const u8,

    /// The map style selected from an available provider.
    map_name: []const u8,

    /// No longer used. Always returns `RequestBasedUsage`.
    pricing_plan: ?PricingPlan = null,

    /// Tags associated with the map resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp for when the map resource was last update in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    update_time: i64,

    pub const json_field_names = .{
        .configuration = "Configuration",
        .create_time = "CreateTime",
        .data_source = "DataSource",
        .description = "Description",
        .map_arn = "MapArn",
        .map_name = "MapName",
        .pricing_plan = "PricingPlan",
        .tags = "Tags",
        .update_time = "UpdateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeMapInput, options: CallOptions) !DescribeMapOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeMapInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo", "Location", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/maps/v0/maps/");
    try path_buf.appendSlice(allocator, input.map_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeMapOutput {
    const result: DescribeMapOutput = try aws.json.parseJsonObject(
        DescribeMapOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
