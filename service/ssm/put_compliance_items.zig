const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ComplianceExecutionSummary = @import("compliance_execution_summary.zig").ComplianceExecutionSummary;
const ComplianceItemEntry = @import("compliance_item_entry.zig").ComplianceItemEntry;
const ComplianceUploadType = @import("compliance_upload_type.zig").ComplianceUploadType;

pub const PutComplianceItemsInput = struct {
    /// Specify the compliance type. For example, specify Association (for a State
    /// Manager
    /// association), Patch, or Custom:`string`.
    compliance_type: []const u8,

    /// A summary of the call execution that includes an execution ID, the type of
    /// execution (for
    /// example, `Command`), and the date/time of the execution using a datetime
    /// object that
    /// is saved in the following format: `yyyy-MM-dd'T'HH:mm:ss'Z'`
    execution_summary: ComplianceExecutionSummary,

    /// MD5 or SHA-256 content hash. The content hash is used to determine if
    /// existing information
    /// should be overwritten or ignored. If the content hashes match, the request
    /// to put compliance
    /// information is ignored.
    item_content_hash: ?[]const u8 = null,

    /// Information about the compliance as defined by the resource type. For
    /// example, for a patch
    /// compliance type, `Items` includes information about the PatchSeverity,
    /// Classification,
    /// and so on.
    items: []const ComplianceItemEntry,

    /// Specify an ID for this resource. For a managed node, this is the node ID.
    resource_id: []const u8,

    /// Specify the type of resource. `ManagedInstance` is currently the only
    /// supported
    /// resource type.
    resource_type: []const u8,

    /// The mode for uploading compliance items. You can specify `COMPLETE` or
    /// `PARTIAL`. In `COMPLETE` mode, the system overwrites all existing
    /// compliance information for the resource. You must provide a full list of
    /// compliance items each
    /// time you send the request.
    ///
    /// In `PARTIAL` mode, the system overwrites compliance information for a
    /// specific
    /// association. The association must be configured with `SyncCompliance` set to
    /// `MANUAL`. By default, all requests use `COMPLETE` mode.
    ///
    /// This attribute is only valid for association compliance.
    upload_type: ?ComplianceUploadType = null,

    pub const json_field_names = .{
        .compliance_type = "ComplianceType",
        .execution_summary = "ExecutionSummary",
        .item_content_hash = "ItemContentHash",
        .items = "Items",
        .resource_id = "ResourceId",
        .resource_type = "ResourceType",
        .upload_type = "UploadType",
    };
};

pub const PutComplianceItemsOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutComplianceItemsInput, options: CallOptions) !PutComplianceItemsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutComplianceItemsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.PutComplianceItems");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutComplianceItemsOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
