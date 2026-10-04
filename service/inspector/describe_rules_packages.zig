const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Locale = @import("locale.zig").Locale;
const FailedItemDetails = @import("failed_item_details.zig").FailedItemDetails;
const RulesPackage = @import("rules_package.zig").RulesPackage;

pub const DescribeRulesPackagesInput = struct {
    /// The locale that you want to translate a rules package description into.
    locale: ?Locale = null,

    /// The ARN that specifies the rules package that you want to describe.
    rules_package_arns: []const []const u8,

    pub const json_field_names = .{
        .locale = "locale",
        .rules_package_arns = "rulesPackageArns",
    };
};

pub const DescribeRulesPackagesOutput = struct {
    /// Rules package details that cannot be described. An error code is provided
    /// for each
    /// failed item.
    failed_items: ?[]const aws.map.MapEntry(FailedItemDetails) = null,

    /// Information about the rules package.
    rules_packages: ?[]const RulesPackage = null,

    pub const json_field_names = .{
        .failed_items = "failedItems",
        .rules_packages = "rulesPackages",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: DescribeRulesPackagesInput, options: CallOptions) !DescribeRulesPackagesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: DescribeRulesPackagesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector", "Inspector", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "InspectorService.DescribeRulesPackages");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !DescribeRulesPackagesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(DescribeRulesPackagesOutput, body, allocator);
}
