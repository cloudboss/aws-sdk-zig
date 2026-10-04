const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ServiceType = @import("service_type.zig").ServiceType;
const FeatureMetadata = @import("feature_metadata.zig").FeatureMetadata;

pub const GetResourceMetadataInput = struct {
    /// An immutable identifier for a data source that is unique for an Amazon Web
    /// Services Region.
    /// Performance Insights gathers metrics from this data source. To use a DB
    /// instance as a data source,
    /// specify its `DbiResourceId` value. For example, specify
    /// `db-ABCDEFGHIJKLMNOPQRSTU1VW2X`.
    identifier: []const u8,

    /// The Amazon Web Services service for which Performance Insights returns
    /// metrics.
    service_type: ServiceType,

    pub const json_field_names = .{
        .identifier = "Identifier",
        .service_type = "ServiceType",
    };
};

pub const GetResourceMetadataOutput = struct {
    /// The metadata for different features. For example, the metadata might
    /// indicate that a feature is
    /// turned on or off on a specific DB instance.
    features: ?[]const aws.map.MapEntry(FeatureMetadata) = null,

    /// An immutable identifier for a data source that is unique for an Amazon Web
    /// Services Region.
    ///
    /// Performance Insights gathers metrics from this data source. To use a DB
    /// instance as a data source,
    /// specify its `DbiResourceId` value. For example, specify
    /// `db-ABCDEFGHIJKLMNOPQRSTU1VW2X`.
    identifier: ?[]const u8 = null,

    pub const json_field_names = .{
        .features = "Features",
        .identifier = "Identifier",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetResourceMetadataInput, options: CallOptions) !GetResourceMetadataOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "pi", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetResourceMetadataInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("pi", "PI", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "PerformanceInsightsv20180227.GetResourceMetadata");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetResourceMetadataOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GetResourceMetadataOutput, body, allocator);
}
