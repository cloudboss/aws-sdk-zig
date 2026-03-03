/// The details of an `AppInstance`, an instance of an Amazon Chime SDK
/// messaging
/// application.
pub const AppInstance = struct {
    /// The ARN of the messaging instance.
    app_instance_arn: ?[]const u8 = null,

    /// The time at which an `AppInstance` was created. In epoch milliseconds.
    created_timestamp: ?i64 = null,

    /// The time an `AppInstance` was last updated. In epoch milliseconds.
    last_updated_timestamp: ?i64 = null,

    /// The metadata of an `AppInstance`.
    metadata: ?[]const u8 = null,

    /// The name of an `AppInstance`.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_instance_arn = "AppInstanceArn",
        .created_timestamp = "CreatedTimestamp",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .metadata = "Metadata",
        .name = "Name",
    };
};
