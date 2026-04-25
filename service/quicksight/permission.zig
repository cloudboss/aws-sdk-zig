/// A structure that contains the permission information for one principal
/// against one flow.
pub const Permission = struct {
    /// A list of actions that the principal can perform against the flow.
    ///
    /// The following are the list of values to set a principal as a flow owner:
    ///
    /// * quicksight:PublishFlow
    ///
    /// * quicksight:GetFlow
    ///
    /// * quicksight:UpdateFlowPermissions
    ///
    /// * quicksight:GetFlowSession
    ///
    /// * quicksight:StartFlowSession
    ///
    /// * quicksight:StopFlowSession
    ///
    /// * quicksight:UpdateFlowSession
    ///
    /// * quicksight:UnpublishFlow
    ///
    /// * quicksight:GetFlowStages
    ///
    /// * quicksight:DeleteFlow
    ///
    /// * quicksight:DescribeFlowPermissions
    ///
    /// * quicksight:UpdateFlow
    ///
    /// * quicksight:CreatePresignedUrl
    ///
    /// The following are the list of values to set a principal as a flow viewer:
    ///
    /// * quicksight:GetFlow
    ///
    /// * quicksight:UpdateFlowSession
    ///
    /// * quicksight:StartFlowSession
    ///
    /// * quicksight:StopFlowSession
    ///
    /// * quicksight:GetFlowSession
    ///
    /// * quicksight:CreatePresignedUrl
    ///
    /// * quicksight:GetFlowStages
    actions: []const []const u8,

    /// The Amazon Resource Name (ARN) of the principal.
    /// This can be an Amazon Quick user, group or namespace associated with the
    /// flow.
    /// Namespace principal can only be set as a viewer and will grant everyone in
    /// the same namespace viewer permissions.
    principal: []const u8,

    pub const json_field_names = .{
        .actions = "Actions",
        .principal = "Principal",
    };
};
