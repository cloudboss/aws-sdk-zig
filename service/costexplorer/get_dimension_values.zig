const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const Context = @import("context.zig").Context;
const Dimension = @import("dimension.zig").Dimension;
const Expression = @import("expression.zig").Expression;
const SortDefinition = @import("sort_definition.zig").SortDefinition;
const DateInterval = @import("date_interval.zig").DateInterval;
const DimensionValuesWithAttributes = @import("dimension_values_with_attributes.zig").DimensionValuesWithAttributes;

pub const GetDimensionValuesInput = struct {
    /// The Amazon Resource Name (ARN) that uniquely identifies a specific billing
    /// view. The ARN
    /// is used to specify which particular billing view you want to interact with
    /// or retrieve
    /// information from when making API calls related to Amazon Web Services
    /// Billing and Cost
    /// Management features. The BillingViewArn can be retrieved by calling the
    /// ListBillingViews
    /// API.
    billing_view_arn: ?[]const u8 = null,

    /// The context for the call to `GetDimensionValues`. This can be
    /// `RESERVATIONS` or `COST_AND_USAGE`. The default value is
    /// `COST_AND_USAGE`. If the context is set to `RESERVATIONS`, the
    /// resulting dimension values can be used in the `GetReservationUtilization`
    /// operation. If the context is set to `COST_AND_USAGE`, the resulting
    /// dimension
    /// values can be used in the `GetCostAndUsage` operation.
    ///
    /// If you set the context to `COST_AND_USAGE`, you can use the following
    /// dimensions for searching:
    ///
    /// * AZ - The Availability Zone. An example is `us-east-1a`.
    ///
    /// * BILLING_ENTITY - The Amazon Web Services seller that your account is with.
    ///   Possible
    /// values are the following:
    ///
    /// - Amazon Web Services(Amazon Web Services): The entity that sells Amazon Web
    /// Services services.
    ///
    /// - AISPL (Amazon Internet Services Pvt. Ltd.): The local Indian entity that's
    /// an acting
    /// reseller for Amazon Web Services services in India.
    ///
    /// - Amazon Web Services Marketplace: The entity that supports the sale of
    /// solutions that are built on
    /// Amazon Web Services by third-party software providers.
    ///
    /// * CACHE_ENGINE - The Amazon ElastiCache operating system. Examples are
    ///   Windows or
    /// Linux.
    ///
    /// * DEPLOYMENT_OPTION - The scope of Amazon Relational Database Service
    ///   deployments.
    /// Valid values are `SingleAZ` and `MultiAZ`.
    ///
    /// * DATABASE_ENGINE - The Amazon Relational Database Service database.
    ///   Examples are
    /// Aurora or MySQL.
    ///
    /// * INSTANCE_TYPE - The type of Amazon EC2 instance. An example is
    /// `m4.xlarge`.
    ///
    /// * INSTANCE_TYPE_FAMILY - A family of instance types optimized to fit
    ///   different use
    /// cases. Examples are `Compute Optimized` (for example, `C4`,
    /// `C5`, `C6g`, and `C7g`), `Memory
    /// Optimization` (for example, `R4`, `R5n`, `R5b`,
    /// and `R6g`).
    ///
    /// * INVOICING_ENTITY - The name of the entity that issues the Amazon Web
    ///   Services
    /// invoice.
    ///
    /// * LEGAL_ENTITY_NAME - The name of the organization that sells you Amazon Web
    ///   Services
    /// services, such as Amazon Web Services.
    ///
    /// * LINKED_ACCOUNT - The description in the attribute map that includes the
    ///   full name
    /// of the member account. The value field contains the Amazon Web Services ID
    /// of the member
    /// account.
    ///
    /// * OPERATING_SYSTEM - The operating system. Examples are Windows or Linux.
    ///
    /// * OPERATION - The action performed. Examples include `RunInstance` and
    /// `CreateBucket`.
    ///
    /// * PLATFORM - The Amazon EC2 operating system. Examples are Windows or
    /// Linux.
    ///
    /// * PURCHASE_TYPE - The reservation type of the purchase that this usage is
    ///   related to.
    /// Examples include On-Demand Instances and Standard Reserved Instances.
    ///
    /// * RESERVATION_ID - The unique identifier for an Amazon Web Services
    ///   Reservation
    /// Instance.
    ///
    /// * SAVINGS_PLAN_ARN - The unique identifier for your Savings Plans.
    ///
    /// * SAVINGS_PLANS_TYPE - Type of Savings Plans (EC2 Instance or Compute).
    ///
    /// * SERVICE - The Amazon Web Services service such as Amazon DynamoDB.
    ///
    /// * TENANCY - The tenancy of a resource. Examples are shared or dedicated.
    ///
    /// * USAGE_TYPE - The type of usage. An example is DataTransfer-In-Bytes. The
    ///   response
    /// for the `GetDimensionValues` operation includes a unit attribute. Examples
    /// include GB and Hrs.
    ///
    /// * USAGE_TYPE_GROUP - The grouping of common usage types. An example is
    ///   Amazon EC2:
    /// CloudWatch – Alarms. The response for this operation includes a unit
    /// attribute.
    ///
    /// * REGION - The Amazon Web Services Region.
    ///
    /// * RECORD_TYPE - The different types of charges such as Reserved Instance
    ///   (RI) fees,
    /// usage costs, tax refunds, and credits.
    ///
    /// * RESOURCE_ID - The unique identifier of the resource. ResourceId is an
    ///   opt-in
    /// feature only available for last 14 days for EC2-Compute Service.
    ///
    /// If you set the context to `RESERVATIONS`, you can use the following
    /// dimensions for searching:
    ///
    /// * AZ - The Availability Zone. An example is `us-east-1a`.
    ///
    /// * CACHE_ENGINE - The Amazon ElastiCache operating system. Examples are
    ///   Windows or
    /// Linux.
    ///
    /// * DEPLOYMENT_OPTION - The scope of Amazon Relational Database Service
    ///   deployments.
    /// Valid values are `SingleAZ` and `MultiAZ`.
    ///
    /// * INSTANCE_TYPE - The type of Amazon EC2 instance. An example is
    /// `m4.xlarge`.
    ///
    /// * LINKED_ACCOUNT - The description in the attribute map that includes the
    ///   full name
    /// of the member account. The value field contains the Amazon Web Services ID
    /// of the member
    /// account.
    ///
    /// * PLATFORM - The Amazon EC2 operating system. Examples are Windows or
    /// Linux.
    ///
    /// * REGION - The Amazon Web Services Region.
    ///
    /// * SCOPE (Utilization only) - The scope of a Reserved Instance (RI). Values
    ///   are
    /// regional or a single Availability Zone.
    ///
    /// * TAG (Coverage only) - The tags that are associated with a Reserved
    ///   Instance
    /// (RI).
    ///
    /// * TENANCY - The tenancy of a resource. Examples are shared or dedicated.
    ///
    /// If you set the context to `SAVINGS_PLANS`, you can use the following
    /// dimensions for searching:
    ///
    /// * SAVINGS_PLANS_TYPE - Type of Savings Plans (EC2 Instance or Compute)
    ///
    /// * PAYMENT_OPTION - The payment option for the given Savings Plans (for
    ///   example, All
    /// Upfront)
    ///
    /// * REGION - The Amazon Web Services Region.
    ///
    /// * INSTANCE_TYPE_FAMILY - The family of instances (For example,
    /// `m5`)
    ///
    /// * LINKED_ACCOUNT - The description in the attribute map that includes the
    ///   full name
    /// of the member account. The value field contains the Amazon Web Services ID
    /// of the member
    /// account.
    ///
    /// * SAVINGS_PLAN_ARN - The unique identifier for your Savings Plans.
    context: ?Context = null,

    /// The name of the dimension. Each `Dimension` is available for a different
    /// `Context`. For more information, see `Context`.
    /// `LINK_ACCOUNT_NAME` and `SERVICE_CODE` can only be used in
    /// [CostCategoryRule](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/AAPI_CostCategoryRule.html).
    dimension: Dimension,

    filter: ?Expression = null,

    /// This field is only used when SortBy is provided in the request. The maximum
    /// number of
    /// objects that are returned for this request. If MaxResults isn't specified
    /// with SortBy, the
    /// request returns 1000 results as the default value for this parameter.
    ///
    /// For `GetDimensionValues`, MaxResults has an upper limit of 1000.
    max_results: ?i32 = null,

    /// The token to retrieve the next set of results. Amazon Web Services provides
    /// the token
    /// when the response from a previous call has more results than the maximum
    /// page size.
    next_page_token: ?[]const u8 = null,

    /// The value that you want to search the filter values for.
    search_string: ?[]const u8 = null,

    /// The value that you want to sort the data by.
    ///
    /// The key represents cost and usage metrics. The following values are
    /// supported:
    ///
    /// * `BlendedCost`
    ///
    /// * `UnblendedCost`
    ///
    /// * `AmortizedCost`
    ///
    /// * `NetAmortizedCost`
    ///
    /// * `NetUnblendedCost`
    ///
    /// * `UsageQuantity`
    ///
    /// * `NormalizedUsageAmount`
    ///
    /// The supported values for the `SortOrder` key are `ASCENDING` or
    /// `DESCENDING`.
    ///
    /// When you specify a `SortBy` paramater, the context must be
    /// `COST_AND_USAGE`. Further, when using `SortBy`,
    /// `NextPageToken` and `SearchString` aren't supported.
    sort_by: ?[]const SortDefinition = null,

    /// The start date and end date for retrieving the dimension values. The start
    /// date is
    /// inclusive, but the end date is exclusive. For example, if `start` is
    /// `2017-01-01` and `end` is `2017-05-01`, then the cost and
    /// usage data is retrieved from `2017-01-01` up to and including
    /// `2017-04-30` but not including `2017-05-01`.
    time_period: DateInterval,

    pub const json_field_names = .{
        .billing_view_arn = "BillingViewArn",
        .context = "Context",
        .dimension = "Dimension",
        .filter = "Filter",
        .max_results = "MaxResults",
        .next_page_token = "NextPageToken",
        .search_string = "SearchString",
        .sort_by = "SortBy",
        .time_period = "TimePeriod",
    };
};

pub const GetDimensionValuesOutput = struct {
    /// The filters that you used to filter your request. Some dimensions are
    /// available only
    /// for a specific context.
    ///
    /// If you set the context to `COST_AND_USAGE`, you can use the following
    /// dimensions for searching:
    ///
    /// * AZ - The Availability Zone. An example is `us-east-1a`.
    ///
    /// * DATABASE_ENGINE - The Amazon Relational Database Service database.
    ///   Examples are
    /// Aurora or MySQL.
    ///
    /// * INSTANCE_TYPE - The type of Amazon EC2 instance. An example is
    /// `m4.xlarge`.
    ///
    /// * LEGAL_ENTITY_NAME - The name of the organization that sells you Amazon Web
    ///   Services
    /// services, such as Amazon Web Services.
    ///
    /// * LINKED_ACCOUNT - The description in the attribute map that includes the
    ///   full name
    /// of the member account. The value field contains the Amazon Web Services ID
    /// of the member
    /// account.
    ///
    /// * OPERATING_SYSTEM - The operating system. Examples are Windows or Linux.
    ///
    /// * OPERATION - The action performed. Examples include `RunInstance` and
    /// `CreateBucket`.
    ///
    /// * PLATFORM - The Amazon EC2 operating system. Examples are Windows or
    /// Linux.
    ///
    /// * PURCHASE_TYPE - The reservation type of the purchase to which this usage
    ///   is
    /// related. Examples include On-Demand Instances and Standard Reserved
    /// Instances.
    ///
    /// * SERVICE - The Amazon Web Services service such as Amazon DynamoDB.
    ///
    /// * USAGE_TYPE - The type of usage. An example is DataTransfer-In-Bytes. The
    ///   response
    /// for the `GetDimensionValues` operation includes a unit attribute. Examples
    /// include GB and Hrs.
    ///
    /// * USAGE_TYPE_GROUP - The grouping of common usage types. An example is
    ///   Amazon EC2:
    /// CloudWatch – Alarms. The response for this operation includes a unit
    /// attribute.
    ///
    /// * RECORD_TYPE - The different types of charges such as RI fees, usage costs,
    ///   tax
    /// refunds, and credits.
    ///
    /// * RESOURCE_ID - The unique identifier of the resource. ResourceId is an
    ///   opt-in
    /// feature only available for last 14 days for EC2-Compute Service. You can
    /// opt-in by
    /// enabling `Hourly` and `Resource Level Data` in Cost Management Console
    /// preferences.
    ///
    /// If you set the context to `RESERVATIONS`, you can use the following
    /// dimensions for searching:
    ///
    /// * AZ - The Availability Zone. An example is `us-east-1a`.
    ///
    /// * CACHE_ENGINE - The Amazon ElastiCache operating system. Examples are
    ///   Windows or
    /// Linux.
    ///
    /// * DEPLOYMENT_OPTION - The scope of Amazon Relational Database Service
    ///   deployments.
    /// Valid values are `SingleAZ` and `MultiAZ`.
    ///
    /// * INSTANCE_TYPE - The type of Amazon EC2 instance. An example is
    /// `m4.xlarge`.
    ///
    /// * LINKED_ACCOUNT - The description in the attribute map that includes the
    ///   full name
    /// of the member account. The value field contains the Amazon Web Services ID
    /// of the member
    /// account.
    ///
    /// * PLATFORM - The Amazon EC2 operating system. Examples are Windows or
    /// Linux.
    ///
    /// * REGION - The Amazon Web Services Region.
    ///
    /// * SCOPE (Utilization only) - The scope of a Reserved Instance (RI). Values
    ///   are
    /// regional or a single Availability Zone.
    ///
    /// * TAG (Coverage only) - The tags that are associated with a Reserved
    ///   Instance
    /// (RI).
    ///
    /// * TENANCY - The tenancy of a resource. Examples are shared or dedicated.
    ///
    /// If you set the context to `SAVINGS_PLANS`, you can use the following
    /// dimensions for searching:
    ///
    /// * SAVINGS_PLANS_TYPE - Type of Savings Plans (EC2 Instance or Compute)
    ///
    /// * PAYMENT_OPTION - Payment option for the given Savings Plans (for example,
    ///   All
    /// Upfront)
    ///
    /// * REGION - The Amazon Web Services Region.
    ///
    /// * INSTANCE_TYPE_FAMILY - The family of instances (For example,
    /// `m5`)
    ///
    /// * LINKED_ACCOUNT - The description in the attribute map that includes the
    ///   full name
    /// of the member account. The value field contains the Amazon Web Services ID
    /// of the member
    /// account.
    ///
    /// * SAVINGS_PLAN_ARN - The unique identifier for your Savings Plan
    dimension_values: ?[]const DimensionValuesWithAttributes = null,

    /// The token for the next set of retrievable results. Amazon Web Services
    /// provides the token
    /// when the response from a previous call has more results than the maximum
    /// page size.
    next_page_token: ?[]const u8 = null,

    /// The number of results that Amazon Web Services returned at one time.
    return_size: i32,

    /// The total number of search results.
    total_size: i32,

    pub const json_field_names = .{
        .dimension_values = "DimensionValues",
        .next_page_token = "NextPageToken",
        .return_size = "ReturnSize",
        .total_size = "TotalSize",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: GetDimensionValuesInput, options: CallOptions) !GetDimensionValuesOutput {
    var arena = std.heap.ArenaAllocator.init(client.allocator);
    defer arena.deinit();
    const alloc = arena.allocator();

    var request = try serializeRequest(alloc, input, client.config);
    defer request.deinit(alloc);

    const creds = try client.config.credentials.getCredentials(client.allocator);
    try aws.signing.signRequest(alloc, client.config.io, &request, creds, client.config.region, "ce", client.config.http_client.clock_skew_offset);

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

fn serializeRequest(allocator: std.mem.Allocator, input: GetDimensionValuesInput, config: *aws.Config) !aws.http.Request {
    const endpoint = try config.getEndpointForService("ce", "Cost Explorer", allocator);

    const ep = try aws.url.parseEndpoint(endpoint);

    const body = try aws.json.jsonStringify(input, allocator);

    var request = aws.http.Request.init(ep.host);
    request.method = .POST;
    request.path = "/";
    request.tls = ep.tls;
    request.port = ep.port;
    request.body = body;
    try request.headers.put(allocator, "Content-Type", "application/x-amz-json-1.1");
    try request.headers.put(allocator, "X-Amz-Target", "AWSInsightsIndexService.GetDimensionValues");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !GetDimensionValuesOutput {
    _ = status;
    _ = headers;
    return aws.json.parseJsonObject(GetDimensionValuesOutput, body, allocator);
}
