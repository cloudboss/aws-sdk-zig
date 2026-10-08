const aws = @import("aws");
const std = @import("std");

const Client = @import("client.zig").Client;
const CallOptions = @import("call_options.zig").CallOptions;
const parseErrorResponse = @import("errors.zig").parseErrorResponse;
const OpsItemNotification = @import("ops_item_notification.zig").OpsItemNotification;
const OpsItemDataValue = @import("ops_item_data_value.zig").OpsItemDataValue;
const RelatedOpsItem = @import("related_ops_item.zig").RelatedOpsItem;
const OpsItemStatus = @import("ops_item_status.zig").OpsItemStatus;

pub const UpdateOpsItemInput = struct {
    /// The time a runbook workflow ended. Currently reported only for the OpsItem
    /// type
    /// `/aws/changerequest`.
    actual_end_time: ?i64 = null,

    /// The time a runbook workflow started. Currently reported only for the OpsItem
    /// type
    /// `/aws/changerequest`.
    actual_start_time: ?i64 = null,

    /// Specify a new category for an OpsItem.
    category: ?[]const u8 = null,

    /// User-defined text that contains information about the OpsItem, in Markdown
    /// format.
    description: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of an SNS topic where notifications are sent
    /// when this
    /// OpsItem is edited or changed.
    notifications: ?[]const OpsItemNotification = null,

    /// Add new keys or edit existing key-value pairs of the OperationalData map in
    /// the OpsItem
    /// object.
    ///
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
    /// [Creating OpsItems
    /// manually](https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-manually-create-OpsItems.html) in the *Amazon Web Services Systems Manager User Guide*.
    operational_data: ?[]const aws.map.MapEntry(OpsItemDataValue) = null,

    /// Keys that you want to remove from the OperationalData map.
    operational_data_to_delete: ?[]const []const u8 = null,

    /// The OpsItem Amazon Resource Name (ARN).
    ops_item_arn: ?[]const u8 = null,

    /// The ID of the OpsItem.
    ops_item_id: []const u8,

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

    /// Specify a new severity for an OpsItem.
    severity: ?[]const u8 = null,

    /// The OpsItem status. For more information, see [Editing OpsItem
    /// details](https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-working-with-OpsItems-editing-details.html) in the *Amazon Web Services Systems Manager User Guide*.
    status: ?OpsItemStatus = null,

    /// A short heading that describes the nature of the OpsItem and the impacted
    /// resource.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .actual_end_time = "ActualEndTime",
        .actual_start_time = "ActualStartTime",
        .category = "Category",
        .description = "Description",
        .notifications = "Notifications",
        .operational_data = "OperationalData",
        .operational_data_to_delete = "OperationalDataToDelete",
        .ops_item_arn = "OpsItemArn",
        .ops_item_id = "OpsItemId",
        .planned_end_time = "PlannedEndTime",
        .planned_start_time = "PlannedStartTime",
        .priority = "Priority",
        .related_ops_items = "RelatedOpsItems",
        .severity = "Severity",
        .status = "Status",
        .title = "Title",
    };
};

pub const UpdateOpsItemOutput = struct {};

pub fn execute(client: *Client, allocator: std.mem.Allocator, input: UpdateOpsItemInput, options: CallOptions) !UpdateOpsItemOutput {
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

fn serializeRequest(allocator: std.mem.Allocator, input: UpdateOpsItemInput, config: *aws.Config) !aws.http.Request {
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
    try request.headers.put(allocator, "X-Amz-Target", "AmazonSSM.UpdateOpsItem");

    return request;
}

fn deserializeResponse(allocator: std.mem.Allocator, body: []const u8, status: u16, headers: anytype) !UpdateOpsItemOutput {
    _ = status;
    _ = headers;
    _ = body;
    _ = allocator;
    return .{};
}
