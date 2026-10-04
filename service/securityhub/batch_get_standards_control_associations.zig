const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const StandardsControlAssociationId = @import("standards_control_association_id.zig").StandardsControlAssociationId;
const StandardsControlAssociationDetail = @import("standards_control_association_detail.zig").StandardsControlAssociationDetail;
const UnprocessedStandardsControlAssociation = @import("unprocessed_standards_control_association.zig").UnprocessedStandardsControlAssociation;

pub const BatchGetStandardsControlAssociationsInput = struct {
    /// An array with one or more objects that includes a security control
    /// (identified with `SecurityControlId`, `SecurityControlArn`, or a mix of both
    /// parameters) and the Amazon Resource Name (ARN) of a standard.
    /// This field is used to query the enablement status of a control in a
    /// specified standard. The security control ID or ARN is the same across
    /// standards.
    standards_control_association_ids: []const StandardsControlAssociationId,

    pub const json_field_names = .{
        .standards_control_association_ids = "StandardsControlAssociationIds",
    };
};

pub const BatchGetStandardsControlAssociationsOutput = struct {
    /// Provides the enablement status of a security control in a specified standard
    /// and other details for the control in relation to
    /// the specified standard.
    standards_control_association_details: ?[]const StandardsControlAssociationDetail = null,

    /// A security control (identified with `SecurityControlId`,
    /// `SecurityControlArn`, or a mix of both parameters) whose enablement
    /// status in a specified standard cannot be returned.
    unprocessed_associations: ?[]const UnprocessedStandardsControlAssociation = null,

    pub const json_field_names = .{
        .standards_control_association_details = "StandardsControlAssociationDetails",
        .unprocessed_associations = "UnprocessedAssociations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchGetStandardsControlAssociationsInput, options: CallOptions) !BatchGetStandardsControlAssociationsOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchGetStandardsControlAssociationsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityhub", "SecurityHub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/associations/batchGet";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"StandardsControlAssociationIds\":");
    try aws.json.writeValue(@TypeOf(input.standards_control_association_ids), input.standards_control_association_ids, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchGetStandardsControlAssociationsOutput {
    var result: BatchGetStandardsControlAssociationsOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchGetStandardsControlAssociationsOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
