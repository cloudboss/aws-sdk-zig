const AlarmConfiguration = @import("alarm_configuration.zig").AlarmConfiguration;
const Target = @import("target.zig").Target;

/// The combination of Amazon Web Services Regions and Amazon Web Services
/// accounts targeted by the current Automation
/// execution.
pub const TargetLocation = struct {
    /// The Amazon Web Services accounts targeted by the current Automation
    /// execution.
    accounts: ?[]const []const u8,

    /// Amazon Web Services accounts or organizational units to exclude as expanded
    /// targets.
    exclude_accounts: ?[]const []const u8,

    /// The Automation execution role used by the currently running Automation. If
    /// not specified,
    /// the default value is `AWS-SystemsManager-AutomationExecutionRole`.
    execution_role_name: ?[]const u8,

    /// Indicates whether to include child organizational units (OUs) that are
    /// children of the
    /// targeted OUs. The default is `false`.
    ///
    /// This parameter is not supported by State Manager.
    include_child_organization_units: ?bool,

    /// The Amazon Web Services Regions targeted by the current Automation
    /// execution.
    regions: ?[]const []const u8,

    target_location_alarm_configuration: ?AlarmConfiguration,

    /// The maximum number of Amazon Web Services Regions and Amazon Web Services
    /// accounts allowed to run the Automation
    /// concurrently. `TargetLocationMaxConcurrency` has a default value of 1.
    target_location_max_concurrency: ?[]const u8,

    /// The maximum number of errors allowed before the system stops queueing
    /// additional Automation
    /// executions for the currently running Automation. `TargetLocationMaxErrors`
    /// has a
    /// default value of 0.
    target_location_max_errors: ?[]const u8,

    /// A list of key-value mappings to target resources. If you specify values for
    /// this data type,
    /// you must also specify a value for `TargetParameterName`.
    ///
    /// This `Targets` parameter takes precedence over the
    /// `StartAutomationExecution:Targets` parameter if both are supplied.
    targets: ?[]const Target,

    /// The maximum number of targets allowed to run this task in parallel. This
    /// `TargetsMaxConcurrency` takes precedence over the
    /// `StartAutomationExecution:MaxConcurrency` parameter if both are supplied.
    targets_max_concurrency: ?[]const u8,

    /// The maximum number of errors that are allowed before the system stops
    /// running the automation
    /// on additional targets. This `TargetsMaxErrors` parameter takes precedence
    /// over the
    /// `StartAutomationExecution:MaxErrors` parameter if both are supplied.
    targets_max_errors: ?[]const u8,

    pub const json_field_names = .{
        .accounts = "Accounts",
        .exclude_accounts = "ExcludeAccounts",
        .execution_role_name = "ExecutionRoleName",
        .include_child_organization_units = "IncludeChildOrganizationUnits",
        .regions = "Regions",
        .target_location_alarm_configuration = "TargetLocationAlarmConfiguration",
        .target_location_max_concurrency = "TargetLocationMaxConcurrency",
        .target_location_max_errors = "TargetLocationMaxErrors",
        .targets = "Targets",
        .targets_max_concurrency = "TargetsMaxConcurrency",
        .targets_max_errors = "TargetsMaxErrors",
    };
};
