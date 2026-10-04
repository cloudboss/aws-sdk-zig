const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSourceConfigurationsResult = @import("data_source_configurations_result.zig").DataSourceConfigurationsResult;
const DetectorFeatureConfigurationResult = @import("detector_feature_configuration_result.zig").DetectorFeatureConfigurationResult;
const FindingPublishingFrequency = @import("finding_publishing_frequency.zig").FindingPublishingFrequency;
const DetectorStatus = @import("detector_status.zig").DetectorStatus;

pub const GetDetectorInput = struct {
    /// The unique ID of the detector that you want to get.
    ///
    /// To find the `detectorId` in the current Region, see the Settings page in the
    /// GuardDuty console, or run the
    /// [ListDetectors](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_ListDetectors.html) API.
    detector_id: []const u8,

    pub const json_field_names = .{
        .detector_id = "DetectorId",
    };
};

pub const GetDetectorOutput = struct {
    /// The timestamp of when the detector was created.
    created_at: ?[]const u8 = null,

    /// Describes which data sources are enabled for the detector.
    data_sources: ?DataSourceConfigurationsResult = null,

    /// Describes the features that have been enabled for the detector.
    features: ?[]const DetectorFeatureConfigurationResult = null,

    /// The publishing frequency of the finding.
    finding_publishing_frequency: ?FindingPublishingFrequency = null,

    /// The GuardDuty service role.
    service_role: []const u8,

    /// The detector status.
    status: DetectorStatus,

    /// The tags of the detector resource.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The last-updated timestamp for the detector.
    updated_at: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "CreatedAt",
        .data_sources = "DataSources",
        .features = "Features",
        .finding_publishing_frequency = "FindingPublishingFrequency",
        .service_role = "ServiceRole",
        .status = "Status",
        .tags = "Tags",
        .updated_at = "UpdatedAt",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDetectorInput, options: CallOptions) !GetDetectorOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDetectorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("guardduty", "GuardDuty", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/detector/");
    try path_buf.appendSlice(allocator, input.detector_id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDetectorOutput {
    const result: GetDetectorOutput = try aws.json.parseJsonObject(
        GetDetectorOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
