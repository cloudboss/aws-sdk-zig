const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Ec2DeepInspectionStatus = @import("ec_2_deep_inspection_status.zig").Ec2DeepInspectionStatus;

pub const UpdateEc2DeepInspectionConfigurationInput = struct {
    /// Specify `TRUE` to activate Amazon Inspector deep inspection in your account,
    /// or
    /// `FALSE` to deactivate. Member accounts in an organization cannot deactivate
    /// deep inspection, instead the delegated administrator for the organization
    /// can deactivate a
    /// member account using
    /// [BatchUpdateMemberEc2DeepInspectionStatus](https://docs.aws.amazon.com/inspector/v2/APIReference/API_BatchUpdateMemberEc2DeepInspectionStatus.html).
    activate_deep_inspection: ?bool = null,

    /// The Amazon Inspector deep inspection custom paths you are adding for your
    /// account.
    package_paths: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .activate_deep_inspection = "activateDeepInspection",
        .package_paths = "packagePaths",
    };
};

pub const UpdateEc2DeepInspectionConfigurationOutput = struct {
    /// An error message explaining why new Amazon Inspector deep inspection custom
    /// paths could not be
    /// added.
    error_message: ?[]const u8 = null,

    /// The current Amazon Inspector deep inspection custom paths for the
    /// organization.
    org_package_paths: ?[]const []const u8 = null,

    /// The current Amazon Inspector deep inspection custom paths for your account.
    package_paths: ?[]const []const u8 = null,

    /// The status of Amazon Inspector deep inspection in your account.
    status: ?Ec2DeepInspectionStatus = null,

    pub const json_field_names = .{
        .error_message = "errorMessage",
        .org_package_paths = "orgPackagePaths",
        .package_paths = "packagePaths",
        .status = "status",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateEc2DeepInspectionConfigurationInput, options: CallOptions) !UpdateEc2DeepInspectionConfigurationOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "inspector2", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateEc2DeepInspectionConfigurationInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("inspector2", "Inspector2", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const path = "/ec2deepinspectionconfiguration/update";

    var body_buf: std.ArrayList(u8) = .empty;
    var has_prev = false;
    try body_buf.appendSlice(allocator, "{");

    if (input.activate_deep_inspection) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"activateDeepInspection\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }
    if (input.package_paths) |v| {
        if (has_prev) try body_buf.appendSlice(allocator, ",");
        try body_buf.appendSlice(allocator, "\"packagePaths\":");
        try aws.json.writeValue(@TypeOf(v), v, allocator, &body_buf);
        has_prev = true;
    }

    try body_buf.appendSlice(allocator, "}");
    const body = try body_buf.toOwnedSlice(allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = path;
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/json");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateEc2DeepInspectionConfigurationOutput {
    var result: UpdateEc2DeepInspectionConfigurationOutput = .{};
    if (body.len > 0) {
        result = try aws.json.parseJsonObject(UpdateEc2DeepInspectionConfigurationOutput, body, allocator);
    }
    _ = status;
    _ = headers;

    return result;
}
