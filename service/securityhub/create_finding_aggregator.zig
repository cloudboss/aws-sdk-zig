const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const CreateFindingAggregatorInput = struct {
    /// Indicates whether to aggregate findings from all of the available Regions in
    /// the current partition. Also determines whether to automatically aggregate
    /// findings from new Regions as Security Hub CSPM supports them and you opt
    /// into them.
    ///
    /// The selected option also determines how to use the Regions provided in the
    /// Regions list.
    ///
    /// The options are as follows:
    ///
    /// * `ALL_REGIONS` - Aggregates findings from all of the Regions where Security
    ///   Hub CSPM is enabled. When you choose this option, Security Hub CSPM also
    ///   automatically aggregates findings from new Regions as Security Hub CSPM
    ///   supports them and you opt into them.
    ///
    /// * `ALL_REGIONS_EXCEPT_SPECIFIED` - Aggregates findings from all of the
    ///   Regions where Security Hub CSPM is enabled, except for the Regions listed
    ///   in the `Regions` parameter. When you choose this option, Security Hub CSPM
    ///   also automatically aggregates findings from new Regions as Security Hub
    ///   CSPM supports them and you opt into them.
    ///
    /// * `SPECIFIED_REGIONS` - Aggregates findings only from the Regions listed in
    ///   the `Regions` parameter. Security Hub CSPM does not automatically
    ///   aggregate findings from new Regions.
    ///
    /// * `NO_REGIONS` - Aggregates no data because no Regions are selected as
    ///   linked Regions.
    region_linking_mode: []const u8,

    /// If `RegionLinkingMode` is `ALL_REGIONS_EXCEPT_SPECIFIED`, then this is a
    /// space-separated list of Regions that don't replicate and send findings to
    /// the home Region.
    ///
    /// If `RegionLinkingMode` is `SPECIFIED_REGIONS`, then this is a
    /// space-separated list of Regions that do replicate and send findings to the
    /// home Region.
    ///
    /// An `InvalidInputException` error results if you populate this field while
    /// `RegionLinkingMode` is
    /// `NO_REGIONS`.
    regions: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .region_linking_mode = "RegionLinkingMode",
        .regions = "Regions",
    };
};

pub const CreateFindingAggregatorOutput = struct {
    /// The home Region. Findings generated in linked Regions are replicated and
    /// sent to the home Region.
    finding_aggregation_region: ?[]const u8 = null,

    /// The ARN of the finding aggregator. You use the finding aggregator ARN to
    /// retrieve details for, update, and stop cross-Region aggregation.
    finding_aggregator_arn: ?[]const u8 = null,

    /// Indicates whether to link all Regions, all Regions except for a list of
    /// excluded Regions, or a list of included Regions.
    region_linking_mode: ?[]const u8 = null,

    /// The list of excluded Regions or included Regions.
    regions: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .finding_aggregation_region = "FindingAggregationRegion",
        .finding_aggregator_arn = "FindingAggregatorArn",
        .region_linking_mode = "RegionLinkingMode",
        .regions = "Regions",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateFindingAggregatorInput, options: CallOptions) !CreateFindingAggregatorOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityhub", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateFindingAggregatorInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/findingAggregator/create";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"RegionLinkingMode\":");
    try aws.json.writeValue(@TypeOf(input.region_linking_mode), input.region_linking_mode, allocator, &body_buf);
    has_prev = true;
    if (input.regions) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Regions\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateFindingAggregatorOutput {
    var result: CreateFindingAggregatorOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(CreateFindingAggregatorOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
