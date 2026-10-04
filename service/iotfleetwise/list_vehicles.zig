const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ListResponseScope = @import("list_response_scope.zig").ListResponseScope;
const VehicleSummary = @import("vehicle_summary.zig").VehicleSummary;

pub const ListVehiclesInput = struct {
    /// The fully qualified names of the attributes. You can use this optional
    /// parameter to list the
    /// vehicles containing all the attributes in the request. For example,
    /// `attributeNames`
    /// could be "`Vehicle.Body.Engine.Type, Vehicle.Color`" and the corresponding
    /// `attributeValues` could be "`1.3 L R2, Blue`" . In this case, the API
    /// will filter vehicles with an attribute name `Vehicle.Body.Engine.Type` that
    /// contains
    /// a value of `1.3 L R2` AND an attribute name `Vehicle.Color` that contains
    /// a value of "`Blue`". A request must contain unique values for the
    /// `attributeNames`
    /// filter and the matching number of `attributeValues` filters to return the
    /// subset
    /// of vehicles that match the attributes filter condition.
    attribute_names: ?[]const []const u8 = null,

    /// Static information about a vehicle attribute value in string format. You can
    /// use this optional
    /// parameter in conjunction with `attributeNames` to list the vehicles
    /// containing all
    /// the `attributeValues` corresponding to the `attributeNames` filter. For
    /// example, `attributeValues` could be "`1.3 L R2, Blue`" and the corresponding
    /// `attributeNames` filter could be "`Vehicle.Body.Engine.Type,
    /// Vehicle.Color`".
    /// In this case, the API will filter vehicles with attribute name
    /// `Vehicle.Body.Engine.Type`
    /// that contains a value of `1.3 L R2` AND an attribute name `Vehicle.Color`
    /// that
    /// contains a value of "`Blue`". A request must contain unique values for the
    /// `attributeNames` filter and the matching number of `attributeValues`
    /// filter to return the subset of vehicles that match the attributes filter
    /// condition.
    attribute_values: ?[]const []const u8 = null,

    /// When you set the `listResponseScope` parameter to `METADATA_ONLY`, the list
    /// response includes: vehicle name, Amazon Resource Name (ARN), creation time,
    /// and last modification time.
    list_response_scope: ?ListResponseScope = null,

    /// The maximum number of items to return, between 1 and 100, inclusive.
    max_results: ?i32 = null,

    /// The Amazon Resource Name (ARN) of a vehicle model (model manifest). You can
    /// use this optional
    /// parameter to list only the vehicles created from a certain vehicle model.
    model_manifest_arn: ?[]const u8 = null,

    /// A pagination token for the next set of results.
    ///
    /// If the results of a search are large, only a portion of the results are
    /// returned, and a `nextToken` pagination token is returned in the response. To
    /// retrieve the next set of results, reissue the search request and include the
    /// returned token. When all results have been returned, the response does not
    /// contain a pagination token value.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .attribute_names = "attributeNames",
        .attribute_values = "attributeValues",
        .list_response_scope = "listResponseScope",
        .max_results = "maxResults",
        .model_manifest_arn = "modelManifestArn",
        .next_token = "nextToken",
    };
};

pub const ListVehiclesOutput = struct {
    /// The token to retrieve the next set of results, or `null` if there are no
    /// more results.
    next_token: ?[]const u8 = null,

    /// A list of vehicles and information about them.
    vehicle_summaries: ?[]const VehicleSummary = null,

    pub const json_field_names = .{
        .next_token = "nextToken",
        .vehicle_summaries = "vehicleSummaries",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListVehiclesInput, options: CallOptions) !ListVehiclesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iotfleetwise", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ListVehiclesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iotfleetwise", "IoTFleetWise", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "IoTAutobahnControlPlane.ListVehicles");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListVehiclesOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ListVehiclesOutput, body, allocator);
}
