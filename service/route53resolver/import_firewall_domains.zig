const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const FirewallDomainImportOperation = @import("firewall_domain_import_operation.zig").FirewallDomainImportOperation;
const FirewallDomainListStatus = @import("firewall_domain_list_status.zig").FirewallDomainListStatus;

pub const ImportFirewallDomainsInput = struct {
    /// The fully qualified URL or URI of the file stored in Amazon Simple Storage
    /// Service
    /// (Amazon S3) that contains the list of domains to import.
    ///
    /// The file must be in an S3 bucket that's in the same Region
    /// as your DNS Firewall. The file must be a text file and must contain a single
    /// domain per line.
    domain_file_url: []const u8,

    /// The ID of the domain list that you want to modify with the import operation.
    firewall_domain_list_id: []const u8,

    /// What you want DNS Firewall to do with the domains that are listed in the
    /// file. This must be set to `REPLACE`, which updates the domain list to
    /// exactly match the list in the file.
    operation: FirewallDomainImportOperation,

    pub const json_field_names = .{
        .domain_file_url = "DomainFileUrl",
        .firewall_domain_list_id = "FirewallDomainListId",
        .operation = "Operation",
    };
};

pub const ImportFirewallDomainsOutput = struct {
    /// The Id of the firewall domain list that DNS Firewall just updated.
    id: ?[]const u8 = null,

    /// The name of the domain list.
    name: ?[]const u8 = null,

    /// Status of the import request.
    status: ?FirewallDomainListStatus = null,

    /// Additional information about the status of the list, if available.
    status_message: ?[]const u8 = null,

    pub const json_field_names = .{
        .id = "Id",
        .name = "Name",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: ImportFirewallDomainsInput, options: CallOptions) !ImportFirewallDomainsOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "route53resolver", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: ImportFirewallDomainsInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("route53resolver", "Route53Resolver", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "Route53Resolver.ImportFirewallDomains");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !ImportFirewallDomainsOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(ImportFirewallDomainsOutput, body, allocator);
}
