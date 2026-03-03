const aws = @import("aws");

const OpsItemNotification = @import("ops_item_notification.zig").OpsItemNotification;
const OpsItemDataValue = @import("ops_item_data_value.zig").OpsItemDataValue;
const RelatedOpsItem = @import("related_ops_item.zig").RelatedOpsItem;
const OpsItemStatus = @import("ops_item_status.zig").OpsItemStatus;

/// Operations engineers and IT professionals use Amazon Web Services Systems
/// Manager OpsCenter to view, investigate, and
/// remediate operational work items (OpsItems) impacting the performance and
/// health of their Amazon Web Services
/// resources. OpsCenter is integrated with Amazon EventBridge and Amazon
/// CloudWatch. This
/// means you can configure these services to automatically create an OpsItem in
/// OpsCenter when a
/// CloudWatch alarm enters the ALARM state or when EventBridge processes an
/// event from
/// any Amazon Web Services service that publishes events. Configuring Amazon
/// CloudWatch alarms and EventBridge events to automatically create OpsItems
/// allows you to quickly diagnose and remediate
/// issues with Amazon Web Services resources from a single console.
///
/// To help you diagnose issues, each OpsItem includes contextually relevant
/// information such as
/// the name and ID of the Amazon Web Services resource that generated the
/// OpsItem, alarm or event details, alarm
/// history, and an alarm timeline graph. For the Amazon Web Services resource,
/// OpsCenter aggregates information
/// from Config, CloudTrail logs, and EventBridge, so you don't have
/// to navigate across multiple console pages during your investigation. For
/// more information, see
/// [Amazon Web Services Systems Manager
/// OpsCenter](https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter.html) in the *Amazon Web Services Systems Manager User Guide*.
pub const OpsItem = struct {
    /// The time a runbook workflow ended. Currently reported only for the OpsItem
    /// type
    /// `/aws/changerequest`.
    actual_end_time: ?i64 = null,

    /// The time a runbook workflow started. Currently reported only for the OpsItem
    /// type
    /// `/aws/changerequest`.
    actual_start_time: ?i64 = null,

    /// An OpsItem category. Category options include: Availability, Cost,
    /// Performance, Recovery,
    /// Security.
    category: ?[]const u8 = null,

    /// The ARN of the Amazon Web Services account that created the OpsItem.
    created_by: ?[]const u8 = null,

    /// The date and time the OpsItem was created.
    created_time: ?i64 = null,

    /// The OpsItem description.
    description: ?[]const u8 = null,

    /// The ARN of the Amazon Web Services account that last updated the OpsItem.
    last_modified_by: ?[]const u8 = null,

    /// The date and time the OpsItem was last updated.
    last_modified_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of an Amazon Simple Notification Service
    /// (Amazon SNS) topic where
    /// notifications are sent when this OpsItem is edited or changed.
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
    /// [Creating OpsItems
    /// manually](https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-manually-create-OpsItems.html) in the *Amazon Web Services Systems Manager User Guide*.
    operational_data: ?[]const aws.map.MapEntry(OpsItemDataValue) = null,

    /// The OpsItem Amazon Resource Name (ARN).
    ops_item_arn: ?[]const u8 = null,

    /// The ID of the OpsItem.
    ops_item_id: ?[]const u8 = null,

    /// The type of OpsItem. Systems Manager supports the following types of
    /// OpsItems:
    ///
    /// * `/aws/issue`
    ///
    /// This type of OpsItem is used for default OpsItems created by OpsCenter.
    ///
    /// * `/aws/changerequest`
    ///
    /// This type of OpsItem is used by Change Manager for reviewing and approving
    /// or rejecting change
    /// requests.
    ///
    /// * `/aws/insight`
    ///
    /// This type of OpsItem is used by OpsCenter for aggregating and reporting on
    /// duplicate
    /// OpsItems.
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
    /// OpsItem. For example,
    /// related OpsItems can include OpsItems with similar error messages, impacted
    /// resources, or
    /// statuses for the impacted resource.
    related_ops_items: ?[]const RelatedOpsItem = null,

    /// The severity of the OpsItem. Severity options range from 1 to 4.
    severity: ?[]const u8 = null,

    /// The origin of the OpsItem, such as Amazon EC2 or Systems Manager. The
    /// impacted resource is a subset of
    /// source.
    source: ?[]const u8 = null,

    /// The OpsItem status. For more information, see [Editing OpsItem
    /// details](https://docs.aws.amazon.com/systems-manager/latest/userguide/OpsCenter-working-with-OpsItems-editing-details.html) in the *Amazon Web Services Systems Manager User Guide*.
    status: ?OpsItemStatus = null,

    /// A short heading that describes the nature of the OpsItem and the impacted
    /// resource.
    title: ?[]const u8 = null,

    /// The version of this OpsItem. Each time the OpsItem is edited the version
    /// number increments
    /// by one.
    version: ?[]const u8 = null,

    pub const json_field_names = .{
        .actual_end_time = "ActualEndTime",
        .actual_start_time = "ActualStartTime",
        .category = "Category",
        .created_by = "CreatedBy",
        .created_time = "CreatedTime",
        .description = "Description",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .notifications = "Notifications",
        .operational_data = "OperationalData",
        .ops_item_arn = "OpsItemArn",
        .ops_item_id = "OpsItemId",
        .ops_item_type = "OpsItemType",
        .planned_end_time = "PlannedEndTime",
        .planned_start_time = "PlannedStartTime",
        .priority = "Priority",
        .related_ops_items = "RelatedOpsItems",
        .severity = "Severity",
        .source = "Source",
        .status = "Status",
        .title = "Title",
        .version = "Version",
    };
};
