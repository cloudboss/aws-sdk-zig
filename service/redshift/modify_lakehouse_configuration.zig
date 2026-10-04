const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const LakehouseIdcRegistration = @import("lakehouse_idc_registration.zig").LakehouseIdcRegistration;
const LakehouseRegistration = @import("lakehouse_registration.zig").LakehouseRegistration;

pub const ModifyLakehouseConfigurationInput = struct {
    /// The name of the Glue data catalog that will be associated with the cluster
    /// enabled with Amazon Redshift federated permissions.
    ///
    /// Constraints:
    ///
    /// * Must contain at least one lowercase letter.
    ///
    /// * Can only contain lowercase letters (a-z), numbers (0-9), underscores (_),
    ///   and hyphens (-).
    ///
    /// Pattern: `^[a-z0-9_-]*[a-z]+[a-z0-9_-]*$`
    ///
    /// Example: `my-catalog_01`
    catalog_name: ?[]const u8 = null,

    /// The unique identifier of the cluster whose lakehouse configuration you want
    /// to modify.
    cluster_identifier: []const u8,

    /// A boolean value that, if `true`, validates the request without actually
    /// modifying the lakehouse configuration. Use this to check for errors before
    /// making changes.
    dry_run: ?bool = null,

    /// The Amazon Resource Name (ARN) of the IAM Identity Center application used
    /// for enabling Amazon Web Services IAM Identity Center trusted identity
    /// propagation on a cluster enabled with Amazon Redshift federated permissions.
    lakehouse_idc_application_arn: ?[]const u8 = null,

    /// Modifies the Amazon Web Services IAM Identity Center trusted identity
    /// propagation on a cluster enabled with Amazon Redshift federated permissions.
    /// Valid values are `Associate` or `Disassociate`.
    lakehouse_idc_registration: ?LakehouseIdcRegistration = null,

    /// Specifies whether to register or deregister the cluster with Amazon Redshift
    /// federated permissions. Valid values are `Register` or `Deregister`.
    lakehouse_registration: ?LakehouseRegistration = null,
};

pub const ModifyLakehouseConfigurationOutput = struct {
    /// The Amazon Resource Name (ARN) of the Glue data catalog associated with the
    /// lakehouse configuration.
    catalog_arn: ?[]const u8 = null,

    /// The unique identifier of the cluster associated with this lakehouse
    /// configuration.
    cluster_identifier: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM Identity Center application used
    /// for enabling Amazon Web Services IAM Identity Center trusted identity
    /// propagation on a cluster enabled with Amazon Redshift federated permissions.
    lakehouse_idc_application_arn: ?[]const u8 = null,

    /// The current status of the lakehouse registration. Indicates whether the
    /// cluster is successfully registered with the lakehouse.
    lakehouse_registration_status: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyLakehouseConfigurationInput, options: CallOptions) !ModifyLakehouseConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "redshift", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyLakehouseConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyLakehouseConfiguration&Version=2012-12-01");
    if (input.catalog_name) |v| {
        try body_buf.appendSlice(allocator, "&CatalogName=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cluster_identifier);
    if (input.dry_run) |v| {
        try body_buf.appendSlice(allocator, "&DryRun=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, if (v) "true" else "false");
    }
    if (input.lakehouse_idc_application_arn) |v| {
        try body_buf.appendSlice(allocator, "&LakehouseIdcApplicationArn=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
    }
    if (input.lakehouse_idc_registration) |v| {
        try body_buf.appendSlice(allocator, "&LakehouseIdcRegistration=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    if (input.lakehouse_registration) |v| {
        try body_buf.appendSlice(allocator, "&LakehouseRegistration=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }

    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-www-form-urlencoded");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyLakehouseConfigurationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyLakehouseConfigurationResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyLakehouseConfigurationOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CatalogArn")) {
                    result.catalog_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "ClusterIdentifier")) {
                    result.cluster_identifier = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LakehouseIdcApplicationArn")) {
                    result.lakehouse_idc_application_arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "LakehouseRegistrationStatus")) {
                    result.lakehouse_registration_status = try allocator.dupe(u8, try reader.readElementText());
                } else {
                    try reader.skipElement();
                }
            },
            .element_end => break,
            else => {},
        }
    }

    return result;
}
