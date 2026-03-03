const RepositoryTriggerEventEnum = @import("repository_trigger_event_enum.zig").RepositoryTriggerEventEnum;

/// Information about a trigger for a repository.
///
/// If you want to receive notifications about repository events, consider using
/// notifications instead of
/// triggers. For more information, see [Configuring
/// notifications for repository
/// events](https://docs.aws.amazon.com/codecommit/latest/userguide/how-to-repository-email.html).
pub const RepositoryTrigger = struct {
    /// The branches to be included in the trigger configuration. If you specify an
    /// empty
    /// array, the trigger applies to all branches.
    ///
    /// Although no content is required in the array, you must include the array
    /// itself.
    branches: ?[]const []const u8 = null,

    /// Any custom data associated with the trigger to be included in the
    /// information sent to
    /// the target of the trigger.
    custom_data: ?[]const u8 = null,

    /// The ARN of the resource that is the target for a trigger (for example, the
    /// ARN of a
    /// topic in Amazon SNS).
    destination_arn: []const u8,

    /// The repository events that cause the trigger to run actions in another
    /// service, such
    /// as sending a notification through Amazon SNS.
    ///
    /// The valid value "all" cannot be used with any other values.
    events: []const RepositoryTriggerEventEnum,

    /// The name of the trigger.
    name: []const u8,

    pub const json_field_names = .{
        .branches = "branches",
        .custom_data = "customData",
        .destination_arn = "destinationArn",
        .events = "events",
        .name = "name",
    };
};
