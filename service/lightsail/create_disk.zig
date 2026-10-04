const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const AddOnRequest = @import("add_on_request.zig").AddOnRequest;
const Tag = @import("tag.zig").Tag;
const Operation = @import("operation.zig").Operation;

pub const CreateDiskInput = struct {
    /// An array of objects that represent the add-ons to enable for the new disk.
    add_ons: ?[]const AddOnRequest = null,

    /// The Availability Zone where you want to create the disk (`us-east-2a`). Use
    /// the
    /// same Availability Zone as the Lightsail instance to which you want to attach
    /// the
    /// disk.
    ///
    /// Use the `get regions` operation to list the Availability Zones where
    /// Lightsail is currently available.
    availability_zone: []const u8,

    /// The unique Lightsail disk name (`my-disk`).
    disk_name: []const u8,

    /// The size of the disk in GB (`32`).
    size_in_gb: i32,

    /// The tag keys and optional values to add to the resource during create.
    ///
    /// Use the `TagResource` action to tag a resource after it's created.
    tags: ?[]const Tag = null,

    pub const json_field_names = .{
        .add_ons = "addOns",
        .availability_zone = "availabilityZone",
        .disk_name = "diskName",
        .size_in_gb = "sizeInGb",
        .tags = "tags",
    };
};

pub const CreateDiskOutput = struct {
    /// An array of objects that describe the result of the action, such as the
    /// status of the
    /// request, the timestamp of the request, and the resources affected by the
    /// request.
    operations: ?[]const Operation = null,

    pub const json_field_names = .{
        .operations = "operations",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateDiskInput, options: CallOptions) !CreateDiskOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "lightsail", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateDiskInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("lightsail", "Lightsail", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Lightsail_20161128.CreateDisk");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateDiskOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateDiskOutput, body, allocator);
}
