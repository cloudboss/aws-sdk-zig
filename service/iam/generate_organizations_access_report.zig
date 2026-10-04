const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GenerateOrganizationsAccessReportInput = struct {
    /// The path of the Organizations entity (root, OU, or account). You can build
    /// an entity path
    /// using the known structure of your organization. For example, assume that
    /// your account ID
    /// is `123456789012` and its parent OU ID is `ou-rge0-awsabcde`. The
    /// organization root ID is `r-f6g7h8i9j0example` and your organization ID is
    /// `o-a1b2c3d4e5`. Your entity path is
    /// `o-a1b2c3d4e5/r-f6g7h8i9j0example/ou-rge0-awsabcde/123456789012`.
    entity_path: []const u8,

    /// The identifier of the Organizations service control policy (SCP). This
    /// parameter is
    /// optional.
    ///
    /// This ID is used to generate information about when an account principal that
    /// is
    /// limited by the SCP attempted to access an Amazon Web Services service.
    organizations_policy_id: ?[]const u8 = null,
};

pub const GenerateOrganizationsAccessReportOutput = struct {
    /// The job identifier that you can use in the
    /// [GetOrganizationsAccessReport](https://docs.aws.amazon.com/IAM/latest/APIReference/API_GetOrganizationsAccessReport.html) operation.
    job_id: ?[]const u8 = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GenerateOrganizationsAccessReportInput, options: CallOptions) !GenerateOrganizationsAccessReportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "iam", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GenerateOrganizationsAccessReportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("iam", "IAM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GenerateOrganizationsAccessReport&Version=2010-05-08");
    try body_buf.appendSlice(allocator, "&EntityPath=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.entity_path);
    if (input.organizations_policy_id) |v| {
        try body_buf.appendSlice(allocator, "&OrganizationsPolicyId=");
        try aws.url.appendUrlEncoded(allocator, &body_buf, v);
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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GenerateOrganizationsAccessReportOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GenerateOrganizationsAccessReportResult")) break;
            },
            else => {},
        }
    }

    var result: GenerateOrganizationsAccessReportOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "JobId")) {
                    result.job_id = try allocator.dupe(u8, try reader.readElementText());
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
