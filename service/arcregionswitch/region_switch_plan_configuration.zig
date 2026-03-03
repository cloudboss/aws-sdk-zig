/// Configuration for nested Region switch plans. This allows one Region switch
/// plan to trigger another plan as part of its execution.
pub const RegionSwitchPlanConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the plan configuration.
    arn: []const u8,

    /// The cross account role for the configuration.
    cross_account_role: ?[]const u8 = null,

    /// The external ID (secret key) for the configuration.
    external_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .arn = "arn",
        .cross_account_role = "crossAccountRole",
        .external_id = "externalId",
    };
};
