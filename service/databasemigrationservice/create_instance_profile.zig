const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const InstanceProfile = @import("instance_profile.zig").InstanceProfile;

pub const CreateInstanceProfileInput = struct {
    /// The Availability Zone where the instance profile will be created. The
    /// default
    /// value is a random, system-chosen Availability Zone in the Amazon Web
    /// Services Region where your
    /// data provider is created, for examplem `us-east-1d`.
    availability_zone: ?[]const u8 = null,

    /// A user-friendly description of the instance profile.
    description: ?[]const u8 = null,

    /// A user-friendly name for the instance profile.
    instance_profile_name: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the KMS key that is used to encrypt
    /// the connection parameters for the instance profile.
    ///
    /// If you don't specify a value for the `KmsKeyArn` parameter, then
    /// DMS uses an Amazon Web Services owned encryption key to encrypt your
    /// resources.
    kms_key_arn: ?[]const u8 = null,

    /// Specifies the network type for the instance profile. A value of `IPV4`
    /// represents an instance profile with IPv4 network type and only supports IPv4
    /// addressing.
    /// A value of `IPV6` represents an instance profile with IPv6 network type
    /// and only supports IPv6 addressing. A value of `DUAL` represents an instance
    /// profile with dual network type that supports IPv4 and IPv6 addressing.
    network_type: ?[]const u8 = null,

    /// Specifies the accessibility options for the instance profile. A value of
    /// `true` represents an instance profile with a public IP address. A value of
    /// `false` represents an instance profile with a private IP address. The
    /// default value
    /// is `true`.
    publicly_accessible: ?bool = null,

    /// A subnet group to associate with the instance profile.
    subnet_group_identifier: ?[]const u8 = null,

    /// One or more tags to be assigned to the instance profile.
    tags: ?[]const Tag = null,

    /// Specifies the VPC security group names to be used with the instance profile.
    /// The VPC security group must work with the VPC containing the instance
    /// profile.
    vpc_security_groups: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .availability_zone = "AvailabilityZone",
        .description = "Description",
        .instance_profile_name = "InstanceProfileName",
        .kms_key_arn = "KmsKeyArn",
        .network_type = "NetworkType",
        .publicly_accessible = "PubliclyAccessible",
        .subnet_group_identifier = "SubnetGroupIdentifier",
        .tags = "Tags",
        .vpc_security_groups = "VpcSecurityGroups",
    };
};

pub const CreateInstanceProfileOutput = struct {
    /// The instance profile that was created.
    instance_profile: ?InstanceProfile = null,

    pub const json_field_names = .{
        .instance_profile = "InstanceProfile",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateInstanceProfileInput, options: CallOptions) !CreateInstanceProfileOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "dms", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateInstanceProfileInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("dms", "Database Migration Service", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonDMSv20160101.CreateInstanceProfile");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateInstanceProfileOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateInstanceProfileOutput, body, allocator);
}
