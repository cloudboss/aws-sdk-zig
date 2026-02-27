const BillInterval = @import("bill_interval.zig").BillInterval;
const GroupSharingPreferenceEnum = @import("group_sharing_preference_enum.zig").GroupSharingPreferenceEnum;
const BillScenarioStatus = @import("bill_scenario_status.zig").BillScenarioStatus;

/// Provides a summary of a bill scenario.
pub const BillScenarioSummary = struct {
    /// The time period covered by the bill scenario.
    bill_interval: ?BillInterval,

    /// The arn of the cost category used in the reserved and prioritized group
    /// sharing.
    cost_category_group_sharing_preference_arn: ?[]const u8,

    /// The timestamp when the bill scenario was created.
    created_at: ?i64,

    /// The timestamp when the bill scenario will expire.
    expires_at: ?i64,

    /// An error message if the bill scenario creation or processing failed.
    failure_message: ?[]const u8,

    /// The setting for the reserved instance and savings plan group sharing used in
    /// this estimate.
    group_sharing_preference: ?GroupSharingPreferenceEnum,

    /// The unique identifier of the bill scenario.
    id: []const u8,

    /// The name of the bill scenario.
    name: ?[]const u8,

    /// The current status of the bill scenario.
    status: ?BillScenarioStatus,

    pub const json_field_names = .{
        .bill_interval = "billInterval",
        .cost_category_group_sharing_preference_arn = "costCategoryGroupSharingPreferenceArn",
        .created_at = "createdAt",
        .expires_at = "expiresAt",
        .failure_message = "failureMessage",
        .group_sharing_preference = "groupSharingPreference",
        .id = "id",
        .name = "name",
        .status = "status",
    };
};
