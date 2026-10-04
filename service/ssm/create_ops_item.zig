const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OpsItemNotification = @import("ops_item_notification.zig").OpsItemNotification;
const OpsItemDataValue = @import("ops_item_data_value.zig").OpsItemDataValue;
const RelatedOpsItem = @import("related_ops_item.zig").RelatedOpsItem;
const Tag = @import("tag.zig").Tag;

pub const CreateOpsItemInput = struct {
    /// The target Amazon Web Services account where you want to create an OpsItem.
    /// To make this call, your account
    /// must be configured to work with OpsItems across accounts. For more
    /// information, see [Set up
    /// OpsCenter](https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-setup.html) in the *Amazon Web Services Systems Manager User Guide*.
    account_id: ?[]const u8 = null,

    /// The time a runbook workflow ended. Currently reported only for the OpsItem
    /// type
    /// `/aws/changerequest`.
    actual_end_time: ?i64 = null,

    /// The time a runbook workflow started. Currently reported only for the OpsItem
    /// type
    /// `/aws/changerequest`.
    actual_start_time: ?i64 = null,

    /// Specify a category to assign to an OpsItem.
    category: ?[]const u8 = null,

    /// User-defined text that contains information about the OpsItem, in Markdown
    /// format.
    ///
    /// Provide enough information so that users viewing this OpsItem for the first
    /// time understand
    /// the issue.
    description: []const u8,

    /// The Amazon Resource Name (ARN) of an SNS topic where notifications are sent
    /// when this
    /// OpsItem is edited or changed.
    notifications: ?[]const OpsItemNotification = null,

    /// Operational data is custom data that provides useful reference details about
    /// the OpsItem.
    /// For example, you can specify log files, error strings, license keys,
    /// troubleshooting tips, or
    /// other relevant data. You enter operational data as key-value pairs. The key
    /// has a maximum length
    /// of 128 characters. The value has a maximum size of 20 KB.
    ///
    /// Operational data keys *can't* begin with the following:
    /// `amazon`, `aws`, `amzn`, `ssm`,
    /// `/amazon`, `/aws`, `/amzn`, `/ssm`.
    ///
    /// You can choose to make the data searchable by other users in the account or
    /// you can restrict
    /// search access. Searchable data means that all users with access to the
    /// OpsItem Overview page (as
    /// provided by the DescribeOpsItems API operation) can view and search on the
    /// specified data. Operational data that isn't searchable is only viewable by
    /// users who have access
    /// to the OpsItem (as provided by the GetOpsItem API operation).
    ///
    /// Use the `/aws/resources` key in OperationalData to specify a related
    /// resource in
    /// the request. Use the `/aws/automations` key in OperationalData to associate
    /// an
    /// Automation runbook with the OpsItem. To view Amazon Web Services CLI example
    /// commands that use these keys, see
    /// [Create OpsItems
    /// manually](https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-manually-create-OpsItems.html) in the *Amazon Web Services Systems Manager User Guide*.
    operational_data: ?[]const aws.map.MapEntry(OpsItemDataValue) = null,

    /// The type of OpsItem to create. Systems Manager supports the following types
    /// of OpsItems:
    ///
    /// * `/aws/issue`
    ///
    /// This type of OpsItem is used for default OpsItems created by OpsCenter.
    ///
    /// * `/aws/insight`
    ///
    /// This type of OpsItem is used by OpsCenter for aggregating and reporting on
    /// duplicate
    /// OpsItems.
    ///
    /// * `/aws/changerequest`
    ///
    /// This type of OpsItem is used by Change Manager for reviewing and approving
    /// or rejecting change
    /// requests.
    ///
    /// Amazon Web Services Systems Manager Change Manager is no longer open to new
    /// customers. Existing customers can
    /// continue to use the service as normal. For more information, see
    /// [Amazon Web Services Systems Manager Change Manager availability
    /// change](https://docs.aws.amazon.com/systems-manager/latest/userguide/change-manager-availability-change.html).
    ops_item_type: ?[]const u8 = null,

    /// The time specified in a change request for a runbook workflow to end.
    /// Currently supported
    /// only for the OpsItem type `/aws/changerequest`.
    planned_end_time: ?i64 = null,

    /// The time specified in a change request for a runbook workflow to start.
    /// Currently supported
    /// only for the OpsItem type `/aws/changerequest`.
    planned_start_time: ?i64 = null,

    /// The importance of this OpsItem in relation to other OpsItems in the system.
    priority: ?i32 = null,

    /// One or more OpsItems that share something in common with the current
    /// OpsItems. For example,
    /// related OpsItems can include OpsItems with similar error messages, impacted
    /// resources, or
    /// statuses for the impacted resource.
    related_ops_items: ?[]const RelatedOpsItem = null,

    /// Specify a severity to assign to an OpsItem.
    severity: ?[]const u8 = null,

    /// The origin of the OpsItem, such as Amazon EC2 or Systems Manager.
    ///
    /// The source name can't contain the following strings: `aws`, `amazon`,
    /// and `amzn`.
    source: []const u8,

    /// Optional metadata that you assign to a resource.
    ///
    /// Tags use a key-value pair. For example:
    ///
    /// `Key=Department,Value=Finance`
    ///
    /// To add tags to a new OpsItem, a user must have IAM permissions for both the
    /// `ssm:CreateOpsItems` operation and the `ssm:AddTagsToResource` operation.
    /// To add tags to an existing OpsItem, use the AddTagsToResource
    /// operation.
    tags: ?[]const Tag = null,

    /// A short heading that describes the nature of the OpsItem and the impacted
    /// resource.
    title: []const u8,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .actual_end_time = "ActualEndTime",
        .actual_start_time = "ActualStartTime",
        .category = "Category",
        .description = "Description",
        .notifications = "Notifications",
        .operational_data = "OperationalData",
        .ops_item_type = "OpsItemType",
        .planned_end_time = "PlannedEndTime",
        .planned_start_time = "PlannedStartTime",
        .priority = "Priority",
        .related_ops_items = "RelatedOpsItems",
        .severity = "Severity",
        .source = "Source",
        .tags = "Tags",
        .title = "Title",
    };
};

pub const CreateOpsItemOutput = struct {
    /// The OpsItem Amazon Resource Name (ARN).
    ops_item_arn: ?[]const u8 = null,

    /// The ID of the OpsItem.
    ops_item_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .ops_item_arn = "OpsItemArn",
        .ops_item_id = "OpsItemId",
    };
};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: CreateOpsItemInput, options: CallOptions) !CreateOpsItemOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: CreateOpsItemInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.CreateOpsItem");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !CreateOpsItemOutput {
    _ = status;
    _ = headers;
    if (body.len == 0) return .{};
    return aws.json.parseJsonObject(CreateOpsItemOutput, body, allocator);
}
