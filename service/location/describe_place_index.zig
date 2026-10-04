const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSourceConfiguration = @import("data_source_configuration.zig").DataSourceConfiguration;
const PricingPlan = @import("pricing_plan.zig").PricingPlan;

pub const DescribePlaceIndexInput = struct {
    /// The name of the place index resource.
    index_name: []const u8,

    pub const json_field_names = .{
        .index_name = "IndexName",
    };
};

pub const DescribePlaceIndexOutput = struct {
    /// The timestamp for when the place index resource was created in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    create_time: i64,

    /// The data provider of geospatial data. Values can be one of the following:
    ///
    /// * `Esri`
    /// * `Grab`
    /// * `Here`
    ///
    /// For more information about data providers, see [Amazon Location Service data
    /// providers](https://docs.aws.amazon.com/location/previous/developerguide/what-is-data-provider.html).
    data_source: []const u8,

    /// The specified data storage option for requesting Places.
    data_source_configuration: ?DataSourceConfiguration = null,

    /// The optional description for the place index resource.
    description: []const u8,

    /// The Amazon Resource Name (ARN) for the place index resource. Used to specify
    /// a resource across Amazon Web Services.
    ///
    /// * Format example:
    ///   `arn:aws:geo:region:account-id:place-index/ExamplePlaceIndex`
    index_arn: []const u8,

    /// The name of the place index resource being described.
    index_name: []const u8,

    /// No longer used. Always returns `RequestBasedUsage`.
    pricing_plan: ?PricingPlan = null,

    /// Tags associated with place index resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The timestamp for when the place index resource was last updated in [ISO
    /// 8601](https://www.iso.org/iso-8601-date-and-time-format.html) format:
    /// `YYYY-MM-DDThh:mm:ss.sssZ`.
    update_time: i64,

    pub const json_field_names = .{
        .create_time = "CreateTime",
        .data_source = "DataSource",
        .data_source_configuration = "DataSourceConfiguration",
        .description = "Description",
        .index_arn = "IndexArn",
        .index_name = "IndexName",
        .pricing_plan = "PricingPlan",
        .tags = "Tags",
        .update_time = "UpdateTime",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribePlaceIndexInput, options: CallOptions) !DescribePlaceIndexOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribePlaceIndexInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("geo", "Location", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/places/v0/indexes/");
    try path_buf.appendSlice(allocator, input.index_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribePlaceIndexOutput {
    const result: DescribePlaceIndexOutput = try aws.json.parseJsonObject(
        DescribePlaceIndexOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
