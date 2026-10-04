const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AquaConfigurationStatus = @import("aqua_configuration_status.zig").AquaConfigurationStatus;
const AquaConfiguration = @import("aqua_configuration.zig").AquaConfiguration;
const serde = @import("serde.zig");

pub const ModifyAquaConfigurationInput = struct {
    /// This parameter is retired. Amazon Redshift automatically determines whether
    /// to use AQUA (Advanced Query Accelerator).
    aqua_configuration_status: ?AquaConfigurationStatus = null,

    /// The identifier of the cluster to be modified.
    cluster_identifier: []const u8,
};

pub const ModifyAquaConfigurationOutput = struct {
    /// This parameter is retired. Amazon Redshift automatically determines whether
    /// to use AQUA (Advanced Query Accelerator).
    aqua_configuration: ?AquaConfiguration = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ModifyAquaConfigurationInput, options: CallOptions) !ModifyAquaConfigurationOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: ModifyAquaConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("redshift", "Redshift", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=ModifyAquaConfiguration&Version=2012-12-01");
    if (input.aqua_configuration_status) |v| {
        try body_buf.appendSlice(allocator, "&AquaConfigurationStatus=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v.wireName());
    }
    try body_buf.appendSlice(allocator, "&ClusterIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.cluster_identifier);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ModifyAquaConfigurationOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "ModifyAquaConfigurationResult")) break;
            },
            else => {},
        }
    }

    var result: ModifyAquaConfigurationOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "AquaConfiguration")) {
                    result.aqua_configuration = try serde.deserializeAquaConfiguration(allocator, &reader);
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
