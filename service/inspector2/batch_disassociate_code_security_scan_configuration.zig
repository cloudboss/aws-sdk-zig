const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const DisassociateConfigurationRequest = @import("disassociate_configuration_request.zig").DisassociateConfigurationRequest;
const FailedAssociationResult = @import("failed_association_result.zig").FailedAssociationResult;
const SuccessfulAssociationResult = @import("successful_association_result.zig").SuccessfulAssociationResult;

pub const BatchDisassociateCodeSecurityScanConfigurationInput = struct {
    /// A list of code repositories to disassociate from the specified scan
    /// configuration.
    disassociate_configuration_requests: []const DisassociateConfigurationRequest,

    pub const json_field_names = .{
        .disassociate_configuration_requests = "disassociateConfigurationRequests",
    };
};

pub const BatchDisassociateCodeSecurityScanConfigurationOutput = struct {
    /// Details of any code repositories that failed to be disassociated from the
    /// scan
    /// configuration.
    failed_associations: ?[]const FailedAssociationResult = null,

    /// Details of code repositories that were successfully disassociated from the
    /// scan
    /// configuration.
    successful_associations: ?[]const SuccessfulAssociationResult = null,

    pub const json_field_names = .{
        .failed_associations = "failedAssociations",
        .successful_associations = "successfulAssociations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: BatchDisassociateCodeSecurityScanConfigurationInput, options: CallOptions) !BatchDisassociateCodeSecurityScanConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: BatchDisassociateCodeSecurityScanConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/codesecurity/scan-configuration/batch/disassociate";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"disassociateConfigurationRequests\":");
    try aws.json.writeValue(@TypeOf(input.disassociate_configuration_requests), input.disassociate_configuration_requests, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !BatchDisassociateCodeSecurityScanConfigurationOutput {
    var result: BatchDisassociateCodeSecurityScanConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(BatchDisassociateCodeSecurityScanConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
