const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const ServiceError = @import("errors.zig").ServiceError;
const DataSetType = @import("data_set_type.zig").DataSetType;

pub const GenerateDataSetInput = struct {
    /// (Optional) Key-value pairs which will be returned, unmodified, in the
    /// Amazon SNS notification message and the data set metadata file. These
    /// key-value pairs can be used to correlated responses with tracking
    /// information from other systems.
    customer_defined_values: ?[]const aws.map.StringMapEntry = null,

    /// The date a data set was published.
    /// For daily data sets, provide a date with day-level granularity for the
    /// desired day.
    /// For monthly data sets except those with prefix disbursed_amount, provide a
    /// date with month-level granularity for the desired month (the day value will
    /// be ignored).
    /// For data sets with prefix disbursed_amount, provide a date with day-level
    /// granularity for the desired day. For these data sets we will look backwards
    /// in time over the range of 31 days until the first data set is found (the
    /// latest one).
    data_set_publication_date: i64,

    /// The desired data set type.
    ///
    /// * **customer_subscriber_hourly_monthly_subscriptions**
    ///
    /// From 2017-09-15 to present: Available daily by 24:00 UTC.
    ///
    /// * **customer_subscriber_annual_subscriptions**
    ///
    /// From 2017-09-15 to present: Available daily by 24:00 UTC.
    ///
    /// * **daily_business_usage_by_instance_type**
    ///
    /// From 2017-09-15 to present: Available daily by 24:00 UTC.
    ///
    /// * **daily_business_fees**
    ///
    /// From 2017-09-15 to present: Available daily by 24:00 UTC.
    ///
    /// * **daily_business_free_trial_conversions**
    ///
    /// From 2017-09-15 to present: Available daily by 24:00 UTC.
    ///
    /// * **daily_business_new_instances**
    ///
    /// From 2017-09-15 to present: Available daily by 24:00 UTC.
    ///
    /// * **daily_business_new_product_subscribers**
    ///
    /// From 2017-09-15 to present: Available daily by 24:00 UTC.
    ///
    /// * **daily_business_canceled_product_subscribers**
    ///
    /// From 2017-09-15 to present: Available daily by 24:00 UTC.
    ///
    /// * **monthly_revenue_billing_and_revenue_data**
    ///
    /// From 2017-09-15 to present: Available monthly on the 15th day of the month
    /// by 24:00 UTC. Data includes metered transactions (e.g. hourly) from one
    /// month prior.
    ///
    /// * **monthly_revenue_annual_subscriptions**
    ///
    /// From 2017-09-15 to present: Available monthly on the 15th day of the month
    /// by 24:00 UTC. Data includes up-front software charges (e.g. annual) from one
    /// month prior.
    ///
    /// * **monthly_revenue_field_demonstration_usage**
    ///
    /// From 2018-03-15 to present: Available monthly on the 15th day of the month
    /// by 24:00 UTC.
    ///
    /// * **monthly_revenue_flexible_payment_schedule**
    ///
    /// From 2018-11-15 to present: Available monthly on the 15th day of the month
    /// by 24:00 UTC.
    ///
    /// * **disbursed_amount_by_product**
    ///
    /// From 2017-09-15 to present: Available every 30 days by 24:00 UTC.
    ///
    /// * **disbursed_amount_by_instance_hours**
    ///
    /// From 2017-09-15 to present: Available every 30 days by 24:00 UTC.
    ///
    /// * **disbursed_amount_by_customer_geo**
    ///
    /// From 2017-09-15 to present: Available every 30 days by 24:00 UTC.
    ///
    /// * **disbursed_amount_by_age_of_uncollected_funds**
    ///
    /// From 2017-09-15 to present: Available every 30 days by 24:00 UTC.
    ///
    /// * **disbursed_amount_by_age_of_disbursed_funds**
    ///
    /// From 2017-09-15 to present: Available every 30 days by 24:00 UTC.
    ///
    /// * **disbursed_amount_by_age_of_past_due_funds**
    ///
    /// From 2018-04-07 to present: Available every 30 days by 24:00 UTC.
    ///
    /// * **disbursed_amount_by_uncollected_funds_breakdown**
    ///
    /// From 2019-10-04 to present: Available every 30 days by 24:00 UTC.
    ///
    /// * **sales_compensation_billed_revenue**
    ///
    /// From 2017-09-15 to present: Available monthly on the 15th day of the month
    /// by 24:00 UTC. Data includes metered transactions (e.g. hourly) from one
    /// month prior, and up-front software charges (e.g. annual) from one month
    /// prior.
    ///
    /// * **us_sales_and_use_tax_records**
    ///
    /// From 2017-09-15 to present: Available monthly on the 15th day of the month
    /// by 24:00 UTC.
    ///
    /// * **disbursed_amount_by_product_with_uncollected_funds**
    ///
    /// This data set is deprecated. Download related reports from AMMP instead!
    ///
    /// * **customer_profile_by_industry**
    ///
    /// This data set is deprecated. Download related reports from AMMP instead!
    ///
    /// * **customer_profile_by_revenue**
    ///
    /// This data set is deprecated. Download related reports from AMMP instead!
    ///
    /// * **customer_profile_by_geography**
    ///
    /// This data set is deprecated. Download related reports from AMMP instead!
    data_set_type: DataSetType,

    /// The name (friendly name, not ARN) of the destination S3 bucket.
    destination_s3_bucket_name: []const u8,

    /// (Optional) The desired S3 prefix for the published data set, similar to a
    /// directory path in standard file systems.
    /// For example, if given the bucket name "mybucket" and the prefix
    /// "myprefix/mydatasets", the output file
    /// "outputfile" would be published to
    /// "s3://mybucket/myprefix/mydatasets/outputfile".
    /// If the prefix directory structure does not exist, it will be created.
    /// If no prefix is provided, the data set will be published to the S3 bucket
    /// root.
    destination_s3_prefix: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the Role with an attached permissions
    /// policy to interact with the provided
    /// AWS services.
    role_name_arn: []const u8,

    /// Amazon Resource Name (ARN) for the SNS Topic that will be notified when the
    /// data set has been published or if an
    /// error has occurred.
    sns_topic_arn: []const u8,

    pub const json_field_names = .{
        .customer_defined_values = "customerDefinedValues",
        .data_set_publication_date = "dataSetPublicationDate",
        .data_set_type = "dataSetType",
        .destination_s3_bucket_name = "destinationS3BucketName",
        .destination_s3_prefix = "destinationS3Prefix",
        .role_name_arn = "roleNameArn",
        .sns_topic_arn = "snsTopicArn",
    };
};

pub const GenerateDataSetOutput = struct {
    /// A unique identifier representing a specific request to the GenerateDataSet
    /// operation. This identifier can be
    /// used to correlate a request with notifications from the SNS topic.
    data_set_request_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .data_set_request_id = "dataSetRequestId",
    };
};

pub const Options = struct {
    diagnostic: ?*ServiceError = null,
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GenerateDataSetInput, options: Options) !GenerateDataSetOutput {
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
            d.* = parseErrorResponse(response.body, response.status, client.allocator) catch .{ .kind = .{ .unknown = .{ .http_status = @intCast(response.status) } } };
        }
        return error.ServiceError;
    }

    const result = try deserializeResponse(response.body, response.status, response.headers, allocator);
    return result;
}

fn serializeRequest(alloc: std.mem.Allocator, input: GenerateDataSetInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("marketplacecommerceanalytics", "Marketplace Commerce Analytics", alloc);

    const host = aws.url.parseHost(endpoint);
    const tls = !std.mem.startsWith(u8, endpoint, "http://");
    const port = aws.url.parsePort(endpoint);

    const body = try aws.json.jsonStringify(input, alloc);

    var request = aws.http.Request.init(host);
    request.method = .POST;
    request.path = "/";
    request.tls = tls;
    request.port = port;
    request.body = body;
    try request.headers.put(alloc, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(alloc, "X-Amz-Target", "MarketplaceCommerceAnalytics20150701.GenerateDataSet");

    return request;
}

fn deserializeResponse(body: []const u8, status: u16, headers: anytype, alloc: std.mem.Allocator) !GenerateDataSetOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(GenerateDataSetOutput, body, alloc);
}

fn parseErrorResponse(body: []const u8, status: u16, alloc: std.mem.Allocator) !ServiceError {
    const error_code = blk: {
        const type_str = aws.json.findJsonValue(body, "__type") orelse break :blk @as([]const u8, "Unknown");
        if (std.mem.lastIndexOfScalar(u8, type_str, '#')) |idx| {
            break :blk type_str[idx + 1 ..];
        }
        break :blk type_str;
    };
    const error_message = aws.json.findJsonValue(body, "message") orelse aws.json.findJsonValue(body, "Message") orelse "";
    var arena = std.heap.ArenaAllocator.init(alloc);
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
