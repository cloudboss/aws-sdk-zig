const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;

pub const GetDatasetInput = struct {
    /// Specifies the identifier of the dataset to retrieve. For the `default`
    /// dataset, you can specify either `default` or the full dataset Amazon
    /// Resource Name (ARN) in the format
    /// `arn:aws:cloudwatch:*Region*:*account-id*:dataset/default`.
    dataset_identifier: []const u8,

    pub const json_field_names = .{
        .dataset_identifier = "DatasetIdentifier",
    };
};

pub const GetDatasetOutput = struct {
    /// Returns the Amazon Resource Name (ARN) of the dataset, in the format
    /// `arn:aws:cloudwatch:*Region*:*account-id*:dataset/*dataset-id*
    /// `.
    arn: []const u8,

    /// Returns the identifier of the dataset.
    dataset_id: []const u8,

    /// Returns the Amazon Resource Name (ARN) of the customer managed Amazon Web
    /// Services
    /// KMS key that is currently associated with the dataset, if any. If the
    /// dataset is not
    /// associated with a customer managed KMS key, this field is not included in
    /// the
    /// response and the dataset is encrypted at rest using an Amazon Web Services
    /// owned
    /// key.
    kms_key_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "Arn",
        .dataset_id = "DatasetId",
        .kms_key_arn = "KmsKeyArn",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDatasetInput, options: CallOptions) !GetDatasetOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "monitoring", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDatasetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("monitoring", "CloudWatch", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    var body_buf: std.ArrayList(u8) = .empty;

    try body_buf.appendSlice(allocator, "Action=GetDataset&Version=2010-08-01");
    try body_buf.appendSlice(allocator, "&DatasetIdentifier=");
    try aws.url.appendUrlEncoded(allocator, &body_buf, input.dataset_identifier);

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

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDatasetOutput {
    _ = status;
    _ = headers;
    var reader = aws.xml.Reader.init(body);

    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "GetDatasetResult")) break;
            },
            else => {},
        }
    }

    var result: GetDatasetOutput = .{};
    while (try reader.next()) |event| {
        switch (event) {
            .element_start => |e| {
                if (std.mem.eql(u8, e.local, "Arn")) {
                    result.arn = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "DatasetId")) {
                    result.dataset_id = try allocator.dupe(u8, try reader.readElementText());
                } else if (std.mem.eql(u8, e.local, "KmsKeyArn")) {
                    result.kms_key_arn = try allocator.dupe(u8, try reader.readElementText());
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
