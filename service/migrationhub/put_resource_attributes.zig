const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const ResourceAttribute = @import("resource_attribute.zig").ResourceAttribute;

pub const PutResourceAttributesInput = struct {
    /// Optional boolean flag to indicate whether any effect should take place. Used
    /// to test if
    /// the caller has permission to make the call.
    dry_run: ?bool = null,

    /// Unique identifier that references the migration task. *Do not store personal
    /// data in this field.*
    migration_task_name: []const u8,

    /// The name of the ProgressUpdateStream.
    progress_update_stream: []const u8,

    /// Information about the resource that is being migrated. This data will be
    /// used to map the
    /// task to a resource in the Application Discovery Service repository.
    ///
    /// Takes the object array of `ResourceAttribute` where the `Type`
    /// field is reserved for the following values: `IPV4_ADDRESS | IPV6_ADDRESS |
    /// MAC_ADDRESS | FQDN | VM_MANAGER_ID | VM_MANAGED_OBJECT_REFERENCE | VM_NAME |
    /// VM_PATH
    /// | BIOS_ID | MOTHERBOARD_SERIAL_NUMBER` where the identifying value can be a
    /// string up to 256 characters.
    ///
    /// * If any "VM" related value is set for a `ResourceAttribute` object,
    /// it is required that `VM_MANAGER_ID`, as a minimum, is always set. If
    /// `VM_MANAGER_ID` is not set, then all "VM" fields will be discarded
    /// and "VM" fields will not be used for matching the migration task to a server
    /// in
    /// Application Discovery Service repository. See the
    /// [Example](https://docs.aws.amazon.com/migrationhub/latest/ug/API_PutResourceAttributes.html#API_PutResourceAttributes_Examples) section below for a use case of specifying "VM" related
    /// values.
    ///
    /// * If a server you are trying to match has multiple IP or MAC addresses, you
    /// should provide as many as you know in separate type/value pairs passed to
    /// the
    /// `ResourceAttributeList` parameter to maximize the chances of
    /// matching.
    resource_attribute_list: []const ResourceAttribute,

    pub const json_field_names = .{
        .dry_run = "DryRun",
        .migration_task_name = "MigrationTaskName",
        .progress_update_stream = "ProgressUpdateStream",
        .resource_attribute_list = "ResourceAttributeList",
    };
};

pub const PutResourceAttributesOutput = struct {
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: PutResourceAttributesInput, options: CallOptions) !PutResourceAttributesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "mgh", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: PutResourceAttributesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("mgh", "Migration Hub", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSMigrationHub.PutResourceAttributes");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !PutResourceAttributesOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
