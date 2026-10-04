const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DataSourceConfigurations = @import("data_source_configurations.zig").DataSourceConfigurations;
const MemberFeaturesConfiguration = @import("member_features_configuration.zig").MemberFeaturesConfiguration;
const UnprocessedAccount = @import("unprocessed_account.zig").UnprocessedAccount;

pub const UpdateMemberDetectorsInput = struct {
    /// A list of member account IDs to be updated.
    account_ids: []const []const u8,

    /// Describes which data sources will be updated.
    data_sources: ?DataSourceConfigurations = null,

    /// The detector ID of the administrator account.
    ///
    /// To find the `detectorId` in the current Region, see the Settings page in the
    /// GuardDuty console, or run the
    /// [ListDetectors](https://docs.aws.amazon.com/guardduty/latest/APIReference/API_ListDetectors.html) API.
    detector_id: []const u8,

    /// A list of features that will be updated for the specified member accounts.
    features: ?[]const MemberFeaturesConfiguration = null,

    pub const json_field_names = .{
        .account_ids = "AccountIds",
        .data_sources = "DataSources",
        .detector_id = "DetectorId",
        .features = "Features",
    };
};

pub const UpdateMemberDetectorsOutput = struct {
    /// A list of member account IDs that were unable to be processed along with an
    /// explanation for why they were not processed.
    unprocessed_accounts: ?[]const UnprocessedAccount = null,

    pub const json_field_names = .{
        .unprocessed_accounts = "UnprocessedAccounts",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateMemberDetectorsInput, options: CallOptions) !UpdateMemberDetectorsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateMemberDetectorsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("guardduty", "GuardDuty", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/detector/");
    try path_buf.appendSlice(allocator, input.detector_id);
    try path_buf.appendSlice(allocator, "/member/detector/update");
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"AccountIds\":");
    try aws.json.writeValue(@TypeOf(input.account_ids), input.account_ids, allocator, &body_buf);
    has_prev = true;
    if (input.data_sources) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"DataSources\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.features) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Features\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateMemberDetectorsOutput {
    var result: UpdateMemberDetectorsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateMemberDetectorsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
