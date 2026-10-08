const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const SecurityRequirementPackImportStatus = @import("security_requirement_pack_import_status.zig").SecurityRequirementPackImportStatus;
const ManagementType = @import("management_type.zig").ManagementType;
const SecurityRequirementPackStatus = @import("security_requirement_pack_status.zig").SecurityRequirementPackStatus;

pub const GetSecurityRequirementPackInput = struct {
    /// The unique identifier of the security requirement pack to retrieve.
    pack_id: []const u8,

    pub const json_field_names = .{
        .pack_id = "packId",
    };
};

pub const GetSecurityRequirementPackOutput = struct {
    /// The date and time the security requirement pack was created, in UTC format.
    created_at: i64,

    /// A description of the security requirement pack.
    description: ?[]const u8 = null,

    /// The status of the security requirements import workflow for this pack.
    import_status: ?SecurityRequirementPackImportStatus = null,

    /// The identifier of the AWS KMS key used to encrypt pack contents.
    kms_key_id: ?[]const u8 = null,

    /// The management type of the pack. Valid values are AWS_MANAGED and
    /// CUSTOMER_MANAGED.
    management_type: ManagementType,

    /// The name of the security requirement pack.
    name: []const u8,

    /// The unique identifier of the security requirement pack.
    pack_id: []const u8,

    /// The status of the security requirement pack.
    status: SecurityRequirementPackStatus,

    /// The date and time the security requirement pack was last updated, in UTC
    /// format.
    updated_at: i64,

    /// The vendor name for AWS managed packs, such as ISO or NIST.
    vendor_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .created_at = "createdAt",
        .description = "description",
        .import_status = "importStatus",
        .kms_key_id = "kmsKeyId",
        .management_type = "managementType",
        .name = "name",
        .pack_id = "packId",
        .status = "status",
        .updated_at = "updatedAt",
        .vendor_name = "vendorName",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetSecurityRequirementPackInput, options: CallOptions) !GetSecurityRequirementPackOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "securityagent", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetSecurityRequirementPackInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("securityagent", "SecurityAgent", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/GetSecurityRequirementPack";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (has_prev) try body_buf.appendSlice(allocator, ",");
    try body_buf.appendSlice(allocator, "\"packId\":");
    try aws.json.writeValue(@TypeOf(input.pack_id), input.pack_id, allocator, &body_buf);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetSecurityRequirementPackOutput {
    const result: GetSecurityRequirementPackOutput = try aws.json.parseJsonObject(
        GetSecurityRequirementPackOutput,
        if (body.len > 0) body else "{}",
        allocator,
    );
    _ = status;
    _ = headers;

    return result;
}
