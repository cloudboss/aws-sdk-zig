/// Specifies if the billing group has the following features enabled.
pub const ListBillingGroupAccountGrouping = struct {
    /// Specifies if this billing group will automatically associate newly added
    /// Amazon Web Services accounts that join your consolidated billing family.
    auto_associate: ?bool,

    /// The Amazon Resource Name (ARN) that identifies the transfer relationship for
    /// the billing group.
    responsibility_transfer_arn: ?[]const u8,

    pub const json_field_names = .{
        .auto_associate = "AutoAssociate",
        .responsibility_transfer_arn = "ResponsibilityTransferArn",
    };
};
