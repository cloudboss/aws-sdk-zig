const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ImportDataFormat = @import("import_data_format.zig").ImportDataFormat;
const ImportJobStatus = @import("import_job_status.zig").ImportJobStatus;

pub const GetAddressListImportJobInput = struct {
    /// The identifier of the import job that needs to be retrieved.
    job_id: []const u8,

    pub const json_field_names = .{
        .job_id = "JobId",
    };
};

pub const GetAddressListImportJobOutput = struct {
    /// The unique identifier of the address list the import job was created for.
    address_list_id: []const u8,

    /// The timestamp of when the import job was completed.
    completed_timestamp: ?i64 = null,

    /// The timestamp of when the import job was created.
    created_timestamp: i64,

    /// The reason for failure of an import job.
    @"error": ?[]const u8 = null,

    /// The number of input addresses that failed to be imported into the address
    /// list.
    failed_items_count: ?i32 = null,

    /// The format of the input for an import job.
    import_data_format: ?ImportDataFormat = null,

    /// The number of input addresses successfully imported into the address list.
    imported_items_count: ?i32 = null,

    /// The identifier of the import job.
    job_id: []const u8,

    /// A user-friendly name for the import job.
    name: []const u8,

    /// The pre-signed URL target for uploading the input file.
    pre_signed_url: []const u8,

    /// The timestamp of when the import job was started.
    start_timestamp: ?i64 = null,

    /// The status of the import job.
    status: ImportJobStatus,

    pub const json_field_names = .{
        .address_list_id = "AddressListId",
        .completed_timestamp = "CompletedTimestamp",
        .created_timestamp = "CreatedTimestamp",
        .@"error" = "Error",
        .failed_items_count = "FailedItemsCount",
        .import_data_format = "ImportDataFormat",
        .imported_items_count = "ImportedItemsCount",
        .job_id = "JobId",
        .name = "Name",
        .pre_signed_url = "PreSignedUrl",
        .start_timestamp = "StartTimestamp",
        .status = "Status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetAddressListImportJobInput, options: CallOptions) !GetAddressListImportJobOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ses", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetAddressListImportJobInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mail-manager", "MailManager", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "MailManagerSvc.GetAddressListImportJob");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetAddressListImportJobOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetAddressListImportJobOutput, body, allocator);
}
