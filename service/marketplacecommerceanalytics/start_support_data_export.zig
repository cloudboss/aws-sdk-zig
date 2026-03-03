const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const SupportDataSetType = @import("support_data_set_type.zig").SupportDataSetType;

pub const StartSupportDataExportInput = struct {
    /// *This target has been deprecated.* (Optional) Key-value pairs which will be
    /// returned, unmodified, in the
    /// Amazon SNS notification message and the data set metadata file.
    customer_defined_values: ?[]const aws.map.StringMapEntry = null,

    /// *This target has been deprecated.* Specifies the data set type to be written
    /// to the output csv file. The data set types customer_support_contacts_data
    /// and
    /// test_customer_support_contacts_data both result in a csv file containing the
    /// following fields: Product Id, Product Code, Customer Guid,
    /// Subscription Guid, Subscription Start Date, Organization, AWS Account Id,
    /// Given Name, Surname, Telephone Number, Email, Title,
    /// Country Code, ZIP Code, Operation Type, and Operation Time.
    ///
    /// * *customer_support_contacts_data* Customer support contact data. The data
    ///   set will contain all changes (Creates, Updates, and Deletes) to customer
    ///   support contact data from the date specified in the from_date parameter.
    ///
    /// * *test_customer_support_contacts_data* An example data set containing
    ///   static test data in the same format as customer_support_contacts_data
    data_set_type: SupportDataSetType,

    /// *This target has been deprecated.* The name (friendly name, not ARN) of the
    /// destination S3 bucket.
    destination_s3_bucket_name: []const u8,

    /// *This target has been deprecated.* (Optional) The desired S3 prefix for the
    /// published data set, similar to a directory path in standard file systems.
    /// For example, if given the bucket name "mybucket" and the prefix
    /// "myprefix/mydatasets", the output file
    /// "outputfile" would be published to
    /// "s3://mybucket/myprefix/mydatasets/outputfile".
    /// If the prefix directory structure does not exist, it will be created.
    /// If no prefix is provided, the data set will be published to the S3 bucket
    /// root.
    destination_s3_prefix: ?[]const u8 = null,

    /// *This target has been deprecated.* The start date from which to retrieve the
    /// data set in UTC. This parameter only affects the
    /// customer_support_contacts_data data set type.
    from_date: i64,

    /// *This target has been deprecated.* The Amazon Resource Name (ARN) of the
    /// Role with an attached permissions policy to interact with the provided
    /// AWS services.
    role_name_arn: []const u8,

    /// *This target has been deprecated.* Amazon Resource Name (ARN) for the SNS
    /// Topic that will be notified when the data set has been published or if an
    /// error has occurred.
    sns_topic_arn: []const u8,

    pub const json_field_names = .{
        .customer_defined_values = "customerDefinedValues",
        .data_set_type = "dataSetType",
        .destination_s3_bucket_name = "destinationS3BucketName",
        .destination_s3_prefix = "destinationS3Prefix",
        .from_date = "fromDate",
        .role_name_arn = "roleNameArn",
        .sns_topic_arn = "snsTopicArn",
    };
};

pub const StartSupportDataExportOutput = struct {
    /// *This target has been deprecated.* A unique identifier representing a
    /// specific request to the StartSupportDataExport operation. This identifier
    /// can be
    /// used to correlate a request with notifications from the SNS topic.
    data_set_request_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_set_request_id = "dataSetRequestId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: StartSupportDataExportInput, options: Options) !StartSupportDataExportOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(alloc);
    try aws.signing.signRequest(alloc, &request, creds, client.config.region, "marketplacecommerceanalytics");

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

fn serializeRequest(allocator: std.mem.Allocator, input: StartSupportDataExportInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("marketplacecommerceanalytics", "Marketplace Commerce Analytics", allocator);

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
    try request.headers.put(allocator, "X-Amz-Target", "MarketplaceCommerceAnalytics20150701.StartSupportDataExport");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !StartSupportDataExportOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(StartSupportDataExportOutput, body, allocator);
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

    if (std.mem.eql(u8, error_code, "MarketplaceCommerceAnalyticsException")) {
        return .{ .arena = arena, .kind = .{ .marketplace_commerce_analytics_exception = .{
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
