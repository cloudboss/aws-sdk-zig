const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const CreateAssociationBatchRequestEntry = @import("create_association_batch_request_entry.zig").CreateAssociationBatchRequestEntry;
const FailedCreateAssociation = @import("failed_create_association.zig").FailedCreateAssociation;
const AssociationDescription = @import("association_description.zig").AssociationDescription;

pub const CreateAssociationBatchInput = struct {
    /// A role used by association to take actions on your behalf.
    /// State Manager will assume this role and call required APIs when dispatching
    /// configurations to nodes. If not specified, [
    /// service-linked role for Systems
    /// Manager](https://docs.aws.amazon.com/systems-manager/latest/userguide/using-service-linked-roles.html) will be used by default.
    ///
    /// It is recommended that you define a custom IAM role so that you have full
    /// control of
    /// the permissions that State Manager has when taking actions on your behalf.
    ///
    /// Service-linked role support in State Manager is being phased out.
    /// Associations
    /// relying on service-linked role may require updates in the future to continue
    /// functioning properly.
    association_dispatch_assume_role: ?[]const u8 = null,

    /// One or more associations.
    entries: []const CreateAssociationBatchRequestEntry,

    pub const json_field_names = .{
        .association_dispatch_assume_role = "AssociationDispatchAssumeRole",
        .entries = "Entries",
    };
};

pub const CreateAssociationBatchOutput = struct {
    /// Information about the associations that failed.
    failed: ?[]const FailedCreateAssociation = null,

    /// Information about the associations that succeeded.
    successful: ?[]const AssociationDescription = null,

    pub const json_field_names = .{
        .failed = "Failed",
        .successful = "Successful",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateAssociationBatchInput, options: CallOptions) !CreateAssociationBatchOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ssm", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateAssociationBatchInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ssm", "SSM", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.CreateAssociationBatch");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateAssociationBatchOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateAssociationBatchOutput, body, allocator);
}
