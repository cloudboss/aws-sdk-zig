/// The configuration information of the grouping of Amazon Q in Connect users.
pub const GroupingConfiguration = struct {
    /// The criteria used for grouping Amazon Q in Connect users.
    ///
    /// The following is the list of supported criteria values.
    ///
    /// * `RoutingProfileArn`: Grouping the users by their [Amazon Connect routing
    ///   profile
    ///   ARN](https://docs.aws.amazon.com/connect/latest/APIReference/API_RoutingProfile.html). User should have [SearchRoutingProfile](https://docs.aws.amazon.com/connect/latest/APIReference/API_SearchRoutingProfiles.html) and [DescribeRoutingProfile](https://docs.aws.amazon.com/connect/latest/APIReference/API_DescribeRoutingProfile.html) permissions when setting criteria to this value.
    criteria: ?[]const u8 = null,

    /// The list of values that define different groups of Amazon Q in Connect
    /// users.
    ///
    /// * When setting `criteria` to `RoutingProfileArn`, you need to provide a list
    ///   of ARNs of [Amazon Connect routing
    ///   profiles](https://docs.aws.amazon.com/connect/latest/APIReference/API_RoutingProfile.html) as values of this parameter.
    values: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .criteria = "criteria",
        .values = "values",
    };
};
