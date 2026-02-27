/// Provides information about the stack's conformity to its expected template
/// configuration.
pub const AwsCloudFormationStackDriftInformationDetails = struct {
    /// Status of the stack's actual configuration compared to its expected template
    /// configuration.
    stack_drift_status: ?[]const u8,

    pub const json_field_names = .{
        .stack_drift_status = "StackDriftStatus",
    };
};
