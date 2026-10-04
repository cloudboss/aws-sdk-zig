const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSourceConfigurations = @import("data_source_configurations.zig").DataSourceConfigurations;
const DetectorFeatureConfiguration = @import("detector_feature_configuration.zig").DetectorFeatureConfiguration;
const FindingPublishingFrequency = @import("finding_publishing_frequency.zig").FindingPublishingFrequency;
const UnprocessedDataSourcesResult = @import("unprocessed_data_sources_result.zig").UnprocessedDataSourcesResult;

pub const CreateDetectorInput = struct {
    /// The idempotency token for the create request.
    client_token: ?[]const u8 = null,

    /// Describes which data sources will be enabled for the detector.
    ///
    /// There might be regional differences because some data sources might not be
    /// available in all the Amazon Web Services Regions where GuardDuty is
    /// presently supported. For more information, see [Regions and
    /// endpoints](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_regions.html).
    data_sources: ?DataSourceConfigurations = null,

    /// A Boolean value that specifies whether the detector is to be enabled.
    enable: bool,

    /// A list of features that will be configured for the detector.
    features: ?[]const DetectorFeatureConfiguration = null,

    /// A value that specifies how frequently updated findings are exported.
    finding_publishing_frequency: ?FindingPublishingFrequency = null,

    /// The tags to be added to a new detector resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .client_token = "ClientToken",
        .data_sources = "DataSources",
        .enable = "Enable",
        .features = "Features",
        .finding_publishing_frequency = "FindingPublishingFrequency",
        .tags = "Tags",
    };
};

pub const CreateDetectorOutput = struct {
    /// The unique ID of the created detector.
    detector_id: ?[]const u8 = null,

    /// Specifies the data sources that couldn't be enabled when GuardDuty was
    /// enabled for the first time.
    unprocessed_data_sources: ?UnprocessedDataSourcesResult = null,

    pub const json_field_names = .{
        .detector_id = "DetectorId",
        .unprocessed_data_sources = "UnprocessedDataSources",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDetectorInput, options: CallOptions) !CreateDetectorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "guardduty", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDetectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("guardduty", "GuardDuty", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/detector";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.client_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ClientToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.data_sources) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DataSources\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"Enable\":");
    try aws.json.writeValue(@TypeOf(input.enable), input.enable, allocator, &body_buf);
    has_prev = true;
    if (input.features) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Features\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.finding_publishing_frequency) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"FindingPublishingFrequency\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDetectorOutput {
    var result: CreateDetectorOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateDetectorOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
