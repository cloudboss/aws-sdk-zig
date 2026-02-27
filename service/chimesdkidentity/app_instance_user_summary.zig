/// Summary of the details of an `AppInstanceUser`.
pub const AppInstanceUserSummary = struct {
    /// The ARN of the `AppInstanceUser`.
    app_instance_user_arn: ?[]const u8,

    /// The metadata of the `AppInstanceUser`.
    metadata: ?[]const u8,

    /// The name of an `AppInstanceUser`.
    name: ?[]const u8,

    pub const json_field_names = .{
        .app_instance_user_arn = "AppInstanceUserArn",
        .metadata = "Metadata",
        .name = "Name",
    };
};
