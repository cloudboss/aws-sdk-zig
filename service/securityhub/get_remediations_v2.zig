const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const RemediationFilters = @import("remediation_filters.zig").RemediationFilters;
const GuidanceFormat = @import("guidance_format.zig").GuidanceFormat;
const RemediationV2Item = @import("remediation_v2_item.zig").RemediationV2Item;

pub const GetRemediationsV2Input = struct {
    /// Filters remediation targets based on a set of criteria. You can't use
    /// `Filters`
    /// together with `TargetUid` or `MetadataUid`.
    filters: ?RemediationFilters = null,

    /// The format of the remediation guidance examples to return. Valid values are
    /// `All`,
    /// `AwsCli`, `Cli`, `Python`, `Terraform`,
    /// `Cdk`, `CloudFormation`, `IaC`, and `Template`.
    /// If you don't specify a value, all formats are returned. Applies only when
    /// `ShowGuidance` is `true`.
    guidance_format: ?GuidanceFormat = null,

    /// The maximum number of results to return. Valid range is 1-100. If you don't
    /// specify a value,
    /// the operation returns up to 25 results.
    max_results: ?i32 = null,

    /// The unique identifier (ID) of the Security Hub exposure finding, found under
    /// the
    /// `metadata.uid` field of the finding. Returns the remediation targets
    /// associated with
    /// that finding. You can't use `MetadataUid` together with `TargetUid` or
    /// `Filters`.
    metadata_uid: ?[]const u8 = null,

    /// The token used to paginate the remediations target list returned.
    /// On your first call to `GetRemediationsV2`, omit this parameter or set it
    /// to `NULL`. For subsequent calls, use the `NextToken` value returned in
    /// the previous response to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    /// Specifies whether to show remediation target guidance.
    show_guidance: ?bool = null,

    /// The unique identifier (ID) of an existing remediation target to return.
    /// Returns the single
    /// matching target. You can't use `TargetUid` together with `MetadataUid`
    /// or `Filters`.
    target_uid: ?[]const u8 = null,

    pub const json_field_names = .{
        .filters = "Filters",
        .guidance_format = "GuidanceFormat",
        .max_results = "MaxResults",
        .metadata_uid = "MetadataUid",
        .next_token = "NextToken",
        .show_guidance = "ShowGuidance",
        .target_uid = "TargetUid",
    };
};

pub const GetRemediationsV2Output = struct {
    /// An array of remediation targets returned by the operation.
    items: ?[]const RemediationV2Item = null,

    /// The pagination token to use to request the next page of results.
    /// Otherwise, this parameter is null.
    next_token: ?[]const u8 = null,

    pub const json_field_names = .{
        .items = "Items",
        .next_token = "NextToken",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetRemediationsV2Input, options: CallOptions) !GetRemediationsV2Output {
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

fn serializeRequest(allocator: std.mem.Allocator, input: GetRemediationsV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetRemediationsV2";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.filters) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"Filters\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.guidance_format) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"GuidanceFormat\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.metadata_uid) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MetadataUid\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.show_guidance) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"ShowGuidance\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.target_uid) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"TargetUid\":");
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetRemediationsV2Output {
    const result: GetRemediationsV2Output = try aws.json.parseJsonObject(
        GetRemediationsV2Output,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
