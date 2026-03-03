/// Specifies if the billing group has the following features enabled.
pub const UpdateBillingGroupAccountGrouping = struct {
    /// Specifies if this billing group will automatically associate newly added
    /// Amazon Web Services accounts that join your consolidated billing family.
    auto_associate: ?bool = null,

    /// The Amazon Resource Name (ARN) that identifies the transfer relationship.
    /// Note: Modifications to the ResponsibilityTransferArn are not permitted for
    /// existing billing groups.
    responsibility_transfer_arn: ?[]const u8 = null,

    pub const json_field_names = .{
        .auto_associate = "AutoAssociate",
        .responsibility_transfer_arn = "ResponsibilityTransferArn",
    };
};
