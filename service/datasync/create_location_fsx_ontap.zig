const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const ServiceError = @import("errors.zig").ServiceError;
const FsxProtocol = @import("fsx_protocol.zig").FsxProtocol;
const TagListEntry = @import("tag_list_entry.zig").TagListEntry;

pub const CreateLocationFsxOntapInput = struct {
    protocol: FsxProtocol,

    /// Specifies the Amazon EC2 security groups that provide access to your file
    /// system's
    /// preferred subnet.
    ///
    /// The security groups must allow outbound traffic on the following ports
    /// (depending on the
    /// protocol you use):
    ///
    /// * **Network File System (NFS)**: TCP ports 111, 635, and
    /// 2049
    ///
    /// * **Server Message Block (SMB)**: TCP port 445
    ///
    /// Your file system's security groups must also allow inbound traffic on the
    /// same
    /// ports.
    security_group_arns: []const []const u8,

    /// Specifies the ARN of the storage virtual machine (SVM) in your file system
    /// where you want
    /// to copy data to or from.
    storage_virtual_machine_arn: []const u8,

    /// Specifies a path to the file share in the SVM where you want to transfer
    /// data to or
    /// from.
    ///
    /// You can specify a junction path (also known as a mount point), qtree path
    /// (for NFS file
    /// shares), or share name (for SMB file shares). For example, your mount path
    /// might be
    /// `/vol1`, `/vol1/tree1`, or `/share1`.
    ///
    /// Don't specify a junction path in the SVM's root volume. For more
    /// information, see [Managing FSx for ONTAP storage virtual
    /// machines](https://docs.aws.amazon.com/fsx/latest/ONTAPGuide/managing-svms.html) in the *Amazon FSx for NetApp ONTAP User Guide*.
    subdirectory: ?[]const u8 = null,

    /// Specifies labels that help you categorize, filter, and search for your
    /// Amazon Web Services
    /// resources. We recommend creating at least a name tag for your location.
    tags: ?[]const TagListEntry = null,

    pub const json_field_names = .{
        .protocol = "Protocol",
        .security_group_arns = "SecurityGroupArns",
        .storage_virtual_machine_arn = "StorageVirtualMachineArn",
        .subdirectory = "Subdirectory",
        .tags = "Tags",
    };
};

pub const CreateLocationFsxOntapOutput = struct {
    /// Specifies the ARN of the FSx for ONTAP file system location that you
    /// create.
    location_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .location_arn = "LocationArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateLocationFsxOntapInput, options: CallOptions) !CreateLocationFsxOntapOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "datasync");

    var response = try client.http_client.sendRequest(&request);
    defer response.deinit();

    if (!response.isSuccess()) {
        if (options.diagnostic) |d| {
            d.* = parseErrorResponse(client.allocator, response.body, response.status) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(allocator, response.body, response.status, response.headers);
    return result;
}

fn serializeRequest(allocator: std.mem.Allocator, input: CreateLocationFsxOntapInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("datasync", "DataSync", allocator);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "FmrsService.CreateLocationFsxOntap");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateLocationFsxOntapOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateLocationFsxOntapOutput, body, allocator);
}

fn parseErrorResponse(allocator: std.mem.Allocator, body: []const u8, status: u16) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(allocator);
    errdefer arena.deinit();
    const arena_alloc = arena.allocator();
    const owned_message = try arena_alloc.dupe(u8, error_message);
    const owned_request_id = try arena_alloc.dupe(u8, "");

    if (std.mem.eql(u8, error_code, "InternalException")) {
        return .{ .arena = arena, .kind = .{ .internal_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }
    if (std.mem.eql(u8, error_code, "InvalidRequestException")) {
        return .{ .arena = arena, .kind = .{ .invalid_request_exception = .{
            .message = owned_message,
            .request_id = owned_request_id,
        } } };
    }

    const owned_code = try arena_alloc.dupe(u8, error_code);
    return .{ .arena = arena, .kind = .{ .unknown = .{
        .code = owned_code,
        .message = owned_message,
        .request_id = owned_request_id,
        .http_status = status,
    } } };
}
