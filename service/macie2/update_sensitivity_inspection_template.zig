const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SensitivityInspectionTemplateExcludes = @import("sensitivity_inspection_template_excludes.zig").SensitivityInspectionTemplateExcludes;
const SensitivityInspectionTemplateIncludes = @import("sensitivity_inspection_template_includes.zig").SensitivityInspectionTemplateIncludes;

pub const UpdateSensitivityInspectionTemplateInput = struct {
    /// A custom description of the template. The description can contain as many as
    /// 200 characters.
    description: ?[]const u8 = null,

    /// The managed data identifiers to explicitly exclude (not use) when performing
    /// automated sensitive data discovery.
    ///
    /// To exclude an allow list or custom data identifier that's currently included
    /// by the template, update the values for the
    /// SensitivityInspectionTemplateIncludes.allowListIds and
    /// SensitivityInspectionTemplateIncludes.customDataIdentifierIds properties,
    /// respectively.
    excludes: ?SensitivityInspectionTemplateExcludes = null,

    /// The unique identifier for the Amazon Macie resource that the request applies
    /// to.
    id: []const u8,

    /// The allow lists, custom data identifiers, and managed data identifiers to
    /// explicitly include (use) when performing automated sensitive data discovery.
    includes: ?SensitivityInspectionTemplateIncludes = null,

    pub const json_field_names = .{
        .description = "description",
        .excludes = "excludes",
        .id = "id",
        .includes = "includes",
    };
};

pub const UpdateSensitivityInspectionTemplateOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateSensitivityInspectionTemplateInput, options: CallOptions) !UpdateSensitivityInspectionTemplateOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateSensitivityInspectionTemplateInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("macie2", "Macie2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var path_buf: std.ArrayList(u8) = .empty;
    try path_buf.appendSlice(allocator, "/templates/sensitivity-inspections/");
    try path_buf.appendSlice(allocator, input.id);
    const path = try path_buf.toOwnedSlice(allocator);

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.description) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"description\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.excludes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"excludes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.includes) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"includes\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .PUT;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateSensitivityInspectionTemplateOutput {
    _ = allocator;
    _ = body;
    _ = status;
    _ = headers;
    const result: UpdateSensitivityInspectionTemplateOutput = .{};

    return result;
}
