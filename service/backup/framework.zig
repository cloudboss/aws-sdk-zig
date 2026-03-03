/// Contains detailed information about a framework. Frameworks contain
/// controls, which
/// evaluate and report on your backup events and resources. Frameworks generate
/// daily
/// compliance results.
pub const Framework = struct {
    /// The date and time that a framework is created, in ISO 8601 representation.
    /// The value of `CreationTime` is accurate to milliseconds. For example,
    /// 2020-07-10T15:00:00.000-08:00 represents the 10th of July 2020 at 3:00 PM 8
    /// hours behind
    /// UTC.
    creation_time: ?i64 = null,

    /// The deployment status of a framework. The statuses are:
    ///
    /// `CREATE_IN_PROGRESS | UPDATE_IN_PROGRESS | DELETE_IN_PROGRESS | COMPLETED |
    /// FAILED`
    deployment_status: ?[]const u8 = null,

    /// An Amazon Resource Name (ARN) that uniquely identifies a resource. The
    /// format of the ARN
    /// depends on the resource type.
    framework_arn: ?[]const u8 = null,

    /// An optional description of the framework with a maximum 1,024 characters.
    framework_description: ?[]const u8 = null,

    /// The unique name of a framework. This name is between 1 and 256 characters,
    /// starting with
    /// a letter, and consisting of letters (a-z, A-Z), numbers (0-9), and
    /// underscores (_).
    framework_name: ?[]const u8 = null,

    /// The number of controls contained by the framework.
    number_of_controls: i32 = 0,

    pub const json_field_names = .{
        .creation_time = "CreationTime",
        .deployment_status = "DeploymentStatus",
        .framework_arn = "FrameworkArn",
        .framework_description = "FrameworkDescription",
        .framework_name = "FrameworkName",
        .number_of_controls = "NumberOfControls",
    };
};
