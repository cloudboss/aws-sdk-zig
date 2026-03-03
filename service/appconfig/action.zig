/// An action defines the tasks that the extension performs during the AppConfig
/// workflow. Each action includes an action point, as shown in the following
/// list:
///
/// * `PRE_CREATE_HOSTED_CONFIGURATION_VERSION`
///
/// * `PRE_START_DEPLOYMENT`
///
/// * `AT_DEPLOYMENT_TICK`
///
/// * `ON_DEPLOYMENT_START`
///
/// * `ON_DEPLOYMENT_STEP`
///
/// * `ON_DEPLOYMENT_BAKING`
///
/// * `ON_DEPLOYMENT_COMPLETE`
///
/// * `ON_DEPLOYMENT_ROLLED_BACK`
///
/// Each action also includes a name, a URI to an Lambda function, and an
/// Amazon Resource Name (ARN) for an Identity and Access Management assume
/// role. You specify the name,
/// URI, and ARN for each *action point* defined in the extension.
pub const Action = struct {
    /// Information about the action.
    description: ?[]const u8 = null,

    /// The action name.
    name: ?[]const u8 = null,

    /// An Amazon Resource Name (ARN) for an Identity and Access Management assume
    /// role.
    role_arn: ?[]const u8 = null,

    /// The extension URI associated to the action point in the extension
    /// definition. The URI
    /// can be an Amazon Resource Name (ARN) for one of the following: an Lambda
    /// function, an Amazon Simple Queue Service queue, an Amazon Simple
    /// Notification Service topic, or the Amazon EventBridge default event bus.
    uri: ?[]const u8 = null,

    pub const json_field_names = .{
        .description = "Description",
        .name = "Name",
        .role_arn = "RoleArn",
        .uri = "Uri",
    };
};
