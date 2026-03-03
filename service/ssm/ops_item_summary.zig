const aws = @import("aws");

const OpsItemDataValue = @import("ops_item_data_value.zig").OpsItemDataValue;
const OpsItemStatus = @import("ops_item_status.zig").OpsItemStatus;

/// A count of OpsItems.
pub const OpsItemSummary = struct {
    /// The time a runbook workflow ended. Currently reported only for the OpsItem
    /// type
    /// `/aws/changerequest`.
    actual_end_time: ?i64 = null,

    /// The time a runbook workflow started. Currently reported only for the OpsItem
    /// type
    /// `/aws/changerequest`.
    actual_start_time: ?i64 = null,

    /// A list of OpsItems by category.
    category: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) of the IAM entity that created the
    /// OpsItem.
    created_by: ?[]const u8 = null,

    /// The date and time the OpsItem was created.
    created_time: ?i64 = null,

    /// The Amazon Resource Name (ARN) of the IAM entity that created the
    /// OpsItem.
    last_modified_by: ?[]const u8 = null,

    /// The date and time the OpsItem was last updated.
    last_modified_time: ?i64 = null,

    /// Operational data is custom data that provides useful reference details about
    /// the OpsItem.
    operational_data: ?[]const aws.map.MapEntry(OpsItemDataValue) = null,

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

    /// A list of OpsItems by severity.
    severity: ?[]const u8 = null,

    /// The impacted Amazon Web Services resource.
    source: ?[]const u8 = null,

    /// The OpsItem status.
    status: ?OpsItemStatus = null,

    /// A short heading that describes the nature of the OpsItem and the impacted
    /// resource.
    title: ?[]const u8 = null,

    pub const json_field_names = .{
        .actual_end_time = "ActualEndTime",
        .actual_start_time = "ActualStartTime",
        .category = "Category",
        .created_by = "CreatedBy",
        .created_time = "CreatedTime",
        .last_modified_by = "LastModifiedBy",
        .last_modified_time = "LastModifiedTime",
        .operational_data = "OperationalData",
        .ops_item_id = "OpsItemId",
        .ops_item_type = "OpsItemType",
        .planned_end_time = "PlannedEndTime",
        .planned_start_time = "PlannedStartTime",
        .priority = "Priority",
        .severity = "Severity",
        .source = "Source",
        .status = "Status",
        .title = "Title",
    };
};
