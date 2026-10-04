const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreateAndAttachS3AccessPointOntapConfiguration = @import("create_and_attach_s3_access_point_ontap_configuration.zig").CreateAndAttachS3AccessPointOntapConfiguration;
const CreateAndAttachS3AccessPointOpenZFSConfiguration = @import("create_and_attach_s3_access_point_open_zfs_configuration.zig").CreateAndAttachS3AccessPointOpenZFSConfiguration;
const CreateAndAttachS3AccessPointS3Configuration = @import("create_and_attach_s3_access_point_s3_configuration.zig").CreateAndAttachS3AccessPointS3Configuration;
const S3AccessPointAttachmentType = @import("s3_access_point_attachment_type.zig").S3AccessPointAttachmentType;
const S3AccessPointAttachment = @import("s3_access_point_attachment.zig").S3AccessPointAttachment;

pub const CreateAndAttachS3AccessPointInput = struct {
    client_request_token: ?[]const u8 = null,

    /// The name you want to assign to this S3 access point.
    name: []const u8,

    ontap_configuration: ?CreateAndAttachS3AccessPointOntapConfiguration = null,

    /// Specifies the configuration to use when creating and attaching an S3 access
    /// point to an FSx for OpenZFS volume.
    open_zfs_configuration: ?CreateAndAttachS3AccessPointOpenZFSConfiguration = null,

    /// Specifies the virtual private cloud (VPC) configuration if you're creating
    /// an access point that is restricted to a VPC.
    /// For more information, see [Creating access points restricted to a virtual
    /// private
    /// cloud](https://docs.aws.amazon.com/fsx/latest/OpenZFSGuide/access-points-vpc.html).
    s3_access_point: ?CreateAndAttachS3AccessPointS3Configuration = null,

    /// The type of S3 access point you want to create. Only `OpenZFS` is supported.
    @"type": S3AccessPointAttachmentType,

    pub const json_field_names = .{
        .client_request_token = "ClientRequestToken",
        .name = "Name",
        .ontap_configuration = "OntapConfiguration",
        .open_zfs_configuration = "OpenZFSConfiguration",
        .s3_access_point = "S3AccessPoint",
        .@"type" = "Type",
    };
};

pub const CreateAndAttachS3AccessPointOutput = struct {
    /// Describes the configuration of the S3 access point created.
    s3_access_point_attachment: ?S3AccessPointAttachment = null,

    pub const json_field_names = .{
        .s3_access_point_attachment = "S3AccessPointAttachment",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAndAttachS3AccessPointInput, options: CallOptions) !CreateAndAttachS3AccessPointOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "fsx", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAndAttachS3AccessPointInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("fsx", "FSx", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSSimbaAPIService_v20180301.CreateAndAttachS3AccessPoint");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAndAttachS3AccessPointOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateAndAttachS3AccessPointOutput, body, allocator);
}
