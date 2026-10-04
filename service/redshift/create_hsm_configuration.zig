const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const HsmConfiguration = @import("hsm_configuration.zig").HsmConfiguration;
const serde = @import("serde.zig");

pub const CreateHsmConfigurationInput = struct {
    /// A text description of the HSM configuration to be created.
    description: []const u8,

    /// The identifier to be assigned to the new Amazon Redshift HSM configuration.
    hsm_configuration_identifier: []const u8,

    /// The IP address that the Amazon Redshift cluster must use to access the HSM.
    hsm_ip_address: []const u8,

    /// The name of the partition in the HSM where the Amazon Redshift clusters will
    /// store their
    /// database encryption keys.
    hsm_partition_name: []const u8,

    /// The password required to access the HSM partition.
    hsm_partition_password: []const u8,

    /// The HSMs public certificate file. When using Cloud HSM, the file name is
    /// server.pem.
    hsm_server_public_certificate: []const u8,

    /// A list of tag instances.
    tags: ?[]const Tag = null,
};

pub const CreateHsmConfigurationOutput = struct {
    hsm_configuration: ?HsmConfiguration = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateHsmConfigurationInput, options: CallOptions) !CreateHsmConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateHsmConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateHsmConfiguration&Version=2012-12-01");
    try body_buf.appendSlice(allocator, "&Description=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.description);
    try body_buf.appendSlice(allocator, "&HsmConfigurationIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.hsm_configuration_identifier);
    try body_buf.appendSlice(allocator, "&HsmIpAddress=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.hsm_ip_address);
    try body_buf.appendSlice(allocator, "&HsmPartitionName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.hsm_partition_name);
    try body_buf.appendSlice(allocator, "&HsmPartitionPassword=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.hsm_partition_password);
    try body_buf.appendSlice(allocator, "&HsmServerPublicCertificate=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.hsm_server_public_certificate);
    if (input.tags) |list| {
        for (list, 0..) |item, idx| {
            const n = idx + 1;
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.key) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Key=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
            {
                var prefix_buf: [256]u8 = undefined;
                if (item.value) |fv_1| {
                    const field_prefix = std.fmt.bufPrint(&prefix_buf, "&Tags.Tag.{d}.Value=", .{n}) catch continue;
                    try body_buf.appendSlice(allocator, field_prefix);
                    try aws.url.appendUrlEncoded(allocator, &body_buf, fv_1);
                }
            }
        }
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateHsmConfigurationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateHsmConfigurationResult")) break;
            },
            else => {},
        }
    }

    var result: CreateHsmConfigurationOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "HsmConfiguration")) {
                    result.hsm_configuration = try serde.deserializeHsmConfiguration(allocator, &reader);
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
