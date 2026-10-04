const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetExportInput = struct {
    /// The content-type of the export, for example `application/json`. Currently
    /// `application/json` and `application/yaml` are supported for `exportType`
    /// of`oas30` and `swagger`. This should be specified in the `Accept` header for
    /// direct API requests.
    accepts: ?[]const u8 = null,

    /// The type of export. Acceptable values are 'oas30' for OpenAPI 3.0.x and
    /// 'swagger' for Swagger/OpenAPI 2.0.
    export_type: []const u8,

    /// A key-value map of query string parameters that specify properties of the
    /// export, depending on the requested `exportType`. For `exportType`
    /// `oas30` and `swagger`, any combination of the following parameters are
    /// supported: `extensions='integrations'` or `extensions='apigateway'` will
    /// export the API with x-amazon-apigateway-integration extensions.
    /// `extensions='authorizers'` will export the API with
    /// x-amazon-apigateway-authorizer extensions. `postman` will export the API
    /// with Postman extensions, allowing for import to the Postman tool
    parameters: ?[]const aws.map.StringMapEntry = null,

    /// The string identifier of the associated RestApi.
    rest_api_id: []const u8,

    /// The name of the Stage that will be exported.
    stage_name: []const u8,

    pub const json_field_names = .{
        .accepts = "accepts",
        .export_type = "exportType",
        .parameters = "parameters",
        .rest_api_id = "restApiId",
        .stage_name = "stageName",
    };
};

pub const GetExportOutput = struct {
    /// The binary blob response to GetExport, which contains the export.
    body: ?[]const u8 = null,

    /// The content-disposition header value in the HTTP response.
    content_disposition: ?[]const u8 = null,

    /// The content-type header value in the HTTP response. This will correspond to
    /// a valid 'accept' type in the request.
    content_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .body = "body",
        .content_disposition = "contentDisposition",
        .content_type = "contentType",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetExportInput, options: CallOptions) !GetExportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "apigateway", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetExportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("apigateway", "API Gateway", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/restapis/");
    try path_buf.appendSlice(allocator, input.rest_api_id);
    try path_buf.appendSlice(allocator, "/stages/");
    try path_buf.appendSlice(allocator, input.stage_name);
    try path_buf.appendSlice(allocator, "/exports/");
    try path_buf.appendSlice(allocator, input.export_type);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.parameters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"parameters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .GET;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");
    if (input.accepts) |v| {
        try request.headers.put(allocator, "Accept", v);
    }

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetExportOutput {
    var result: GetExportOutput = .{};
    errdefer {
        if (result.content_disposition) |value| allocator.free(value);
        if (result.content_type) |value| allocator.free(value);
        if (result.body) |value| allocator.free(value);
    }
    if (body.len > 0) {
        result.body = try allocator.dupe(u8, body);
    }
    _ = status;
    if (headers.get("content-disposition")) |value| {
        result.content_disposition = try allocator.dupe(u8, value);
    }
    if (headers.get("content-type")) |value| {
        result.content_type = try allocator.dupe(u8, value);
    }

    return result;
}
