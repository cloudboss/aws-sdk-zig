const ExpirationSettings = @import("expiration_settings.zig").ExpirationSettings;

/// The details of an `AppInstanceUser`.
pub const AppInstanceUser = struct {
    /// The ARN of the `AppInstanceUser`.
    app_instance_user_arn: ?[]const u8 = null,

    /// The time at which the `AppInstanceUser` was created.
    created_timestamp: ?i64 = null,

    /// The interval after which an `AppInstanceUser` is automatically deleted.
    expiration_settings: ?ExpirationSettings = null,

    /// The time at which the `AppInstanceUser` was last updated.
    last_updated_timestamp: ?i64 = null,

    /// The metadata of the `AppInstanceUser`.
    metadata: ?[]const u8 = null,

    /// The name of the `AppInstanceUser`.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .app_instance_user_arn = "AppInstanceUserArn",
        .created_timestamp = "CreatedTimestamp",
        .expiration_settings = "ExpirationSettings",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .metadata = "Metadata",
        .name = "Name",
    };
};
