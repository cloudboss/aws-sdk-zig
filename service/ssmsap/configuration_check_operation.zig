const ConfigurationCheckType = @import("configuration_check_type.zig").ConfigurationCheckType;
const RuleStatusCounts = @import("rule_status_counts.zig").RuleStatusCounts;
const OperationStatus = @import("operation_status.zig").OperationStatus;

/// Represents a configuration check operation that has been executed against an
/// application.
pub const ConfigurationCheckOperation = struct {
    /// The ID of the application against which the configuration check was
    /// performed.
    application_id: ?[]const u8,

    /// A description of the configuration check that was performed.
    configuration_check_description: ?[]const u8,

    /// The unique identifier of the configuration check that was performed.
    configuration_check_id: ?ConfigurationCheckType,

    /// The name of the configuration check that was performed.
    configuration_check_name: ?[]const u8,

    /// The time at which the configuration check operation completed.
    end_time: ?i64,

    /// The unique identifier of the configuration check operation.
    id: ?[]const u8,

    /// A summary of all the rule results, showing counts for each status type.
    rule_status_counts: ?RuleStatusCounts,

    /// The time at which the configuration check operation started.
    start_time: ?i64,

    /// The current status of the configuration check operation.
    status: ?OperationStatus,

    /// A message providing additional details about the status of the configuration
    /// check operation.
    status_message: ?[]const u8,

    pub const json_field_names = .{
        .application_id = "ApplicationId",
        .configuration_check_description = "ConfigurationCheckDescription",
        .configuration_check_id = "ConfigurationCheckId",
        .configuration_check_name = "ConfigurationCheckName",
        .end_time = "EndTime",
        .id = "Id",
        .rule_status_counts = "RuleStatusCounts",
        .start_time = "StartTime",
        .status = "Status",
        .status_message = "StatusMessage",
    };
};
