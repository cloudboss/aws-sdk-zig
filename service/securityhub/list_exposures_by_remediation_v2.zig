const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ExposureFinding = @import("exposure_finding.zig").ExposureFinding;
const RemediationResource = @import("remediation_resource.zig").RemediationResource;
const RemediationTrait = @import("remediation_trait.zig").RemediationTrait;

pub const ListExposuresByRemediationV2Input = struct {
    /// The maximum number of results to return. Valid range is 1-100. If you don't
    /// specify a value,
    /// the operation returns up to 25 results.
    max_results: ?i32 = null,

    /// The token used to paginate the exposures list returned.
    /// On your first call to `ListExposuresByRemediationV2`, omit this parameter or
    /// set it
    /// to `NULL`. For subsequent calls, use the `NextToken` value returned in
    /// the previous response to retrieve the next page of results.
    next_token: ?[]const u8 = null,

    /// The unique identifier (ID) of an existing remediation target to list
    /// exposure findings for.
    target_uid: []const u8,

    pub const json_field_names = .{
        .max_results = "MaxResults",
        .next_token = "NextToken",
        .target_uid = "TargetUid",
    };
};

pub const ListExposuresByRemediationV2Output = struct {
    /// An array of exposure findings returned by the operation.
    items: ?[]const ExposureFinding = null,

    /// The pagination token to use to request the next page of results.
    /// Otherwise, this parameter is null.
    next_token: ?[]const u8 = null,

    /// Provides comprehensive details about a resource.
    resource: ?RemediationResource = null,

    /// The unique identifier (ID) of the remediation target that the exposure
    /// findings are associated with.
    target_uid: []const u8,

    /// The total count of exposure findings associated with the remediation target.
    total_count: i32,

    /// The specific trait associated with the remediation target.
    trait: ?RemediationTrait = null,

    pub const json_field_names = .{
        .items = "Items",
        .next_token = "NextToken",
        .resource = "Resource",
        .target_uid = "TargetUid",
        .total_count = "TotalCount",
        .trait = "Trait",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ListExposuresByRemediationV2Input, options: CallOptions) !ListExposuresByRemediationV2Output {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ListExposuresByRemediationV2Input, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ListExposuresByRemediationV2";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.max_results) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"MaxResults\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.next_token) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"NextToken\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"TargetUid\":");
    try aws.json.writeValue(@TypeOf(input.target_uid), input.target_uid, allocator, &body_buf);
    has_prev = true;

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ListExposuresByRemediationV2Output {
    const result: ListExposuresByRemediationV2Output = try aws.json.parseJsonObject(
        ListExposuresByRemediationV2Output,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
