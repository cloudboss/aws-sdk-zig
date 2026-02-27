/// One of the targets for the StackSet. Returned by the
/// [ListStackSetAutoDeploymentTargets](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/API_ListStackSetAutoDeploymentTargets.html) API operation.
pub const StackSetAutoDeploymentTargetSummary = struct {
    /// The organization root ID or organizational unit (OU) IDs where the StackSet
    /// is
    /// targeted.
    organizational_unit_id: ?[]const u8,

    /// The list of Regions targeted for this organization or OU.
    regions: ?[]const []const u8,
};
