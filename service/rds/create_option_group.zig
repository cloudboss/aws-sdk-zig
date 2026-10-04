const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Tag = @import("tag.zig").Tag;
const OptionGroup = @import("option_group.zig").OptionGroup;
const serde = @import("serde.zig");

pub const CreateOptionGroupInput = struct {
    /// The name of the engine to associate this option group with.
    ///
    /// Valid Values:
    ///
    /// * `db2-ae`
    /// * `db2-ce`
    /// * `db2-se`
    /// * `mariadb`
    /// * `mysql`
    /// * `oracle-ee`
    /// * `oracle-ee-cdb`
    /// * `oracle-se2`
    /// * `oracle-se2-cdb`
    /// * `postgres`
    /// * `sqlserver-ee`
    /// * `sqlserver-se`
    /// * `sqlserver-ex`
    /// * `sqlserver-web`
    engine_name: []const u8,

    /// Specifies the major version of the engine that this option group should be
    /// associated with.
    major_engine_version: []const u8,

    /// The description of the option group.
    option_group_description: []const u8,

    /// Specifies the name of the option group to be created.
    ///
    /// Constraints:
    ///
    /// * Must be 1 to 255 letters, numbers, or hyphens
    /// * First character must be a letter
    /// * Can't end with a hyphen or contain two consecutive hyphens
    ///
    /// Example: `myoptiongroup`
    option_group_name: []const u8,

    /// Tags to assign to the option group.
    tags: ?[]const Tag = null,
};

pub const CreateOptionGroupOutput = struct {
    option_group: ?OptionGroup = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateOptionGroupInput, options: CallOptions) !CreateOptionGroupOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "rds", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateOptionGroupInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("rds", "RDS", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=CreateOptionGroup&Version=2014-10-31");
    try body_buf.appendSlice(allocator, "&EngineName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.engine_name);
    try body_buf.appendSlice(allocator, "&MajorEngineVersion=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.major_engine_version);
    try body_buf.appendSlice(allocator, "&OptionGroupDescription=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.option_group_description);
    try body_buf.appendSlice(allocator, "&OptionGroupName=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.option_group_name);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateOptionGroupOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "CreateOptionGroupResult")) break;
            },
            else => {},
        }
    }

    var result: CreateOptionGroupOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "OptionGroup")) {
                    result.option_group = try serde.deserializeOptionGroup(allocator, &reader);
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
