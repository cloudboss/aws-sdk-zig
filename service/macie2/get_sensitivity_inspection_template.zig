const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SensitivityInspectionTemplateExcludes = @import("sensitivity_inspection_template_excludes.zig").SensitivityInspectionTemplateExcludes;
const SensitivityInspectionTemplateIncludes = @import("sensitivity_inspection_template_includes.zig").SensitivityInspectionTemplateIncludes;

pub const GetSensitivityInspectionTemplateInput = struct {
    /// The unique identifier for the Amazon Macie resource that the request applies
    /// to.
    id: []const u8,

    pub const json_field_names = .{
        .id = "id",
    };
};

pub const GetSensitivityInspectionTemplateOutput = struct {
    /// The custom description of the template.
    description: ?[]const u8 = null,

    /// The managed data identifiers that are explicitly excluded (not used) when
    /// performing automated sensitive data discovery.
    excludes: ?SensitivityInspectionTemplateExcludes = null,

    /// The allow lists, custom data identifiers, and managed data identifiers that
    /// are explicitly included (used) when performing automated sensitive data
    /// discovery.
    includes: ?SensitivityInspectionTemplateIncludes = null,

    /// The name of the template: automated-sensitive-data-discovery.
    name: ?[]const u8 = null,

    /// The unique identifier for the template.
    sensitivity_inspection_template_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "description",
        .excludes = "excludes",
        .includes = "includes",
        .name = "name",
        .sensitivity_inspection_template_id = "sensitivityInspectionTemplateId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSensitivityInspectionTemplateInput, options: CallOptions) !GetSensitivityInspectionTemplateOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "macie2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSensitivityInspectionTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/templates/sensitivity-inspections/");
    try path_buf.appendSlice(allocator, input.id);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSensitivityInspectionTemplateOutput {
    var result: GetSensitivityInspectionTemplateOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(GetSensitivityInspectionTemplateOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
