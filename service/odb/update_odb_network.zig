const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Access = @import("access.zig").Access;
const ResourceStatus = @import("resource_status.zig").ResourceStatus;

pub const UpdateOdbNetworkInput = struct {
    /// The cross-Region Amazon S3 restore sources to disable for the ODB network.
    cross_region_s3_restore_sources_to_disable: ?[]const []const u8 = null,

    /// The cross-Region Amazon S3 restore sources to enable for the ODB network.
    cross_region_s3_restore_sources_to_enable: ?[]const []const u8 = null,

    /// The new user-friendly name of the ODB network.
    display_name: ?[]const u8 = null,

    /// The Amazon Web Services Key Management Service (KMS) access configuration
    /// for the ODB network.
    kms_access: ?Access = null,

    /// The Amazon Web Services Key Management Service (KMS) policy document that
    /// defines permissions for key usage within the ODB network.
    kms_policy_document: ?[]const u8 = null,

    /// The unique identifier of the ODB network to update.
    odb_network_id: []const u8,

    /// The list of CIDR ranges from the peered VPC that allow access to the ODB
    /// network.
    peered_cidrs_to_be_added: ?[]const []const u8 = null,

    /// The list of CIDR ranges from the peered VPC to remove from the ODB network.
    peered_cidrs_to_be_removed: ?[]const []const u8 = null,

    /// Specifies the updated configuration for Amazon S3 access from the ODB
    /// network.
    s_3_access: ?Access = null,

    /// Specifies the updated endpoint policy for Amazon S3 access from the ODB
    /// network.
    s_3_policy_document: ?[]const u8 = null,

    /// The Amazon Web Services Security Token Service (STS) access configuration
    /// for the ODB network.
    sts_access: ?Access = null,

    /// The Amazon Web Services Security Token Service (STS) policy document that
    /// defines permissions for token service usage within the ODB network.
    sts_policy_document: ?[]const u8 = null,

    /// Specifies the updated configuration for Zero-ETL access from the ODB
    /// network.
    zero_etl_access: ?Access = null,

    pub const json_field_names = .{
        .cross_region_s3_restore_sources_to_disable = "crossRegionS3RestoreSourcesToDisable",
        .cross_region_s3_restore_sources_to_enable = "crossRegionS3RestoreSourcesToEnable",
        .display_name = "displayName",
        .kms_access = "kmsAccess",
        .kms_policy_document = "kmsPolicyDocument",
        .odb_network_id = "odbNetworkId",
        .peered_cidrs_to_be_added = "peeredCidrsToBeAdded",
        .peered_cidrs_to_be_removed = "peeredCidrsToBeRemoved",
        .s_3_access = "s3Access",
        .s_3_policy_document = "s3PolicyDocument",
        .sts_access = "stsAccess",
        .sts_policy_document = "stsPolicyDocument",
        .zero_etl_access = "zeroEtlAccess",
    };
};

pub const UpdateOdbNetworkOutput = struct {
    /// The user-friendly name of the ODB network.
    display_name: ?[]const u8 = null,

    /// The unique identifier of the ODB network.
    odb_network_id: []const u8,

    /// The current status of the ODB network.
    status: ?ResourceStatus = null,

    /// Additional information about the status of the ODB network.
    status_reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .display_name = "displayName",
        .odb_network_id = "odbNetworkId",
        .status = "status",
        .status_reason = "statusReason",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateOdbNetworkInput, options: CallOptions) !UpdateOdbNetworkOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateOdbNetworkInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "Odb.UpdateOdbNetwork");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateOdbNetworkOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(UpdateOdbNetworkOutput, body, allocator);
}
