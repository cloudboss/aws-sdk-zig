const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CustomerContact = @import("customer_contact.zig").CustomerContact;
const MaintenanceWindow = @import("maintenance_window.zig").MaintenanceWindow;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

pub const CreateCloudExadataInfrastructureInput = struct {
    /// The name of the Availability Zone (AZ) where the Exadata infrastructure is
    /// located.
    ///
    /// This operation requires that you specify a value for either
    /// `availabilityZone` or `availabilityZoneId`.
    ///
    /// Example: `us-east-1a`
    availability_zone: ?[]const u8 = null,

    /// The AZ ID of the AZ where the Exadata infrastructure is located.
    ///
    /// This operation requires that you specify a value for either
    /// `availabilityZone` or `availabilityZoneId`.
    ///
    /// Example: `use1-az1`
    availability_zone_id: ?[]const u8 = null,

    /// A unique, case-sensitive identifier that you provide to ensure the
    /// idempotency of the request. If you don't specify a client token, the Amazon
    /// Web Services SDK automatically generates a client token and uses it for the
    /// request to ensure idempotency. The client token is valid for up to 24 hours
    /// after it's first used.
    client_token: ?[]const u8 = null,

    /// The number of database servers for the Exadata infrastructure. Valid values
    /// for this parameter depend on the shape. To get information about the minimum
    /// and maximum values, use the `ListDbSystemShapes` operation.
    compute_count: i32,

    /// The email addresses of contacts to receive notification from Oracle about
    /// maintenance updates for the Exadata infrastructure.
    customer_contacts_to_send_to_oci: ?[]const CustomerContact = null,

    /// The database server model type of the Exadata infrastructure. For the list
    /// of valid model names, use the `ListDbSystemShapes` operation.
    database_server_type: ?[]const u8 = null,

    /// A user-friendly name for the Exadata infrastructure.
    display_name: []const u8,

    /// The maintenance window configuration for the Exadata Cloud infrastructure.
    ///
    /// This allows you to define when maintenance operations such as patching and
    /// updates can be performed on the infrastructure.
    maintenance_window: ?MaintenanceWindow = null,

    /// The model name of the Exadata infrastructure. For the list of valid model
    /// names, use the `ListDbSystemShapes` operation.
    shape: []const u8,

    /// The number of storage servers to activate for this Exadata infrastructure.
    /// Valid values for this parameter depend on the shape. To get information
    /// about the minimum and maximum values, use the `ListDbSystemShapes`
    /// operation.
    storage_count: i32,

    /// The storage server model type of the Exadata infrastructure. For the list of
    /// valid model names, use the `ListDbSystemShapes` operation.
    storage_server_type: ?[]const u8 = null,

    /// The list of resource tags to apply to the Exadata infrastructure.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .availability_zone = "availabilityZone",
        .availability_zone_id = "availabilityZoneId",
        .client_token = "clientToken",
        .compute_count = "computeCount",
        .customer_contacts_to_send_to_oci = "customerContactsToSendToOCI",
        .database_server_type = "databaseServerType",
        .display_name = "displayName",
        .maintenance_window = "maintenanceWindow",
        .shape = "shape",
        .storage_count = "storageCount",
        .storage_server_type = "storageServerType",
        .tags = "tags",
    };
};

pub const CreateCloudExadataInfrastructureOutput = struct {
    /// The unique identifier of the Exadata infrastructure.
    cloud_exadata_infrastructure_id: []const u8,

    /// The user-friendly name for the Exadata infrastructure.
    display_name: ?[]const u8 = null,

    /// The current status of the Exadata infrastructure.
    status: ?ResourceStatus = null,

    /// Additional information about the status of the Exadata infrastructure.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloud_exadata_infrastructure_id = "cloudExadataInfrastructureId",
        .display_name = "displayName",
        .status = "status",
        .status_reason = "statusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateCloudExadataInfrastructureInput, options: CallOptions) !CreateCloudExadataInfrastructureOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "odb", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateCloudExadataInfrastructureInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("odb", "odb", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.0");
    try request.headers.put(allocator, "X-Amz-Target", "Odb.CreateCloudExadataInfrastructure");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateCloudExadataInfrastructureOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(CreateCloudExadataInfrastructureOutput, body, allocator);
}
