const WorkGroupConfiguration = @import("work_group_configuration.zig").WorkGroupConfiguration;
const WorkGroupState = @import("work_group_state.zig").WorkGroupState;

/// A workgroup, which contains a name, description, creation time, state, and
/// other
/// configuration, listed under WorkGroup$Configuration. Each workgroup
/// enables you to isolate queries for you or your group of users from other
/// queries in the
/// same account, to configure the query results location and the encryption
/// configuration
/// (known as workgroup settings), to enable sending query metrics to Amazon
/// CloudWatch,
/// and to establish per-query data usage control limits for all queries in a
/// workgroup. The
/// workgroup settings override is specified in `EnforceWorkGroupConfiguration`
/// (true/false) in the `WorkGroupConfiguration`. See
/// WorkGroupConfiguration$EnforceWorkGroupConfiguration.
pub const WorkGroup = struct {
    /// The configuration of the workgroup, which includes the location in Amazon S3
    /// where query and calculation results are stored, the encryption
    /// configuration, if any,
    /// used for query and calculation results; whether the Amazon CloudWatch
    /// Metrics are
    /// enabled for the workgroup; whether workgroup settings override client-side
    /// settings; and
    /// the data usage limits for the amount of data scanned per query or per
    /// workgroup. The
    /// workgroup settings override is specified in `EnforceWorkGroupConfiguration`
    /// (true/false) in the `WorkGroupConfiguration`. See
    /// WorkGroupConfiguration$EnforceWorkGroupConfiguration.
    configuration: ?WorkGroupConfiguration,

    /// The date and time the workgroup was created.
    creation_time: ?i64,

    /// The workgroup description.
    description: ?[]const u8,

    /// The ARN of the IAM Identity Center enabled application associated with the
    /// workgroup.
    identity_center_application_arn: ?[]const u8,

    /// The workgroup name.
    name: []const u8,

    /// The state of the workgroup: ENABLED or DISABLED.
    state: ?WorkGroupState,

    pub const json_field_names = .{
        .configuration = "Configuration",
        .creation_time = "CreationTime",
        .description = "Description",
        .identity_center_application_arn = "IdentityCenterApplicationArn",
        .name = "Name",
        .state = "State",
    };
};
