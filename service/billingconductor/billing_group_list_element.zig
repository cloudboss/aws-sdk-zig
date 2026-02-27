const ListBillingGroupAccountGrouping = @import("list_billing_group_account_grouping.zig").ListBillingGroupAccountGrouping;
const BillingGroupType = @import("billing_group_type.zig").BillingGroupType;
const ComputationPreference = @import("computation_preference.zig").ComputationPreference;
const BillingGroupStatus = @import("billing_group_status.zig").BillingGroupStatus;

/// A representation of a billing group.
pub const BillingGroupListElement = struct {
    /// Specifies if the billing group has automatic account association
    /// (`AutoAssociate`) enabled.
    account_grouping: ?ListBillingGroupAccountGrouping,

    /// The Amazon Resource Number (ARN) that can be used to uniquely identify the
    /// billing group.
    arn: ?[]const u8,

    /// The type of billing group.
    billing_group_type: ?BillingGroupType,

    computation_preference: ?ComputationPreference,

    /// The time when the billing group was created.
    creation_time: i64 = 0,

    /// The description of the billing group.
    description: ?[]const u8,

    /// The most recent time when the billing group was modified.
    last_modified_time: i64 = 0,

    /// The name of the billing group.
    name: ?[]const u8,

    /// The account ID that serves as the main account in a billing group.
    primary_account_id: ?[]const u8,

    /// The number of accounts in the particular billing group.
    size: i64 = 0,

    /// The billing group status. Only one of the valid values can be used.
    status: ?BillingGroupStatus,

    /// The reason why the billing group is in its current status.
    status_reason: ?[]const u8,

    pub const json_field_names = .{
        .account_grouping = "AccountGrouping",
        .arn = "Arn",
        .billing_group_type = "BillingGroupType",
        .computation_preference = "ComputationPreference",
        .creation_time = "CreationTime",
        .description = "Description",
        .last_modified_time = "LastModifiedTime",
        .name = "Name",
        .primary_account_id = "PrimaryAccountId",
        .size = "Size",
        .status = "Status",
        .status_reason = "StatusReason",
    };
};
