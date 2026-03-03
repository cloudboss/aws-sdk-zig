/// An option group membership.
pub const AwsRdsDbOptionGroupMembership = struct {
    /// The name of the option group.
    option_group_name: ?[]const u8 = null,

    /// The status of the option group membership.
    status: ?[]const u8 = null,

    pub const json_field_names = .{
        .option_group_name = "OptionGroupName",
        .status = "Status",
    };
};
