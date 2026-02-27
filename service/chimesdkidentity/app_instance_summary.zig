/// Summary of the data for an `AppInstance`.
pub const AppInstanceSummary = struct {
    /// The `AppInstance` ARN.
    app_instance_arn: ?[]const u8,

    /// The metadata of the `AppInstance`.
    metadata: ?[]const u8,

    /// The name of the `AppInstance`.
    name: ?[]const u8,

    pub const json_field_names = .{
        .app_instance_arn = "AppInstanceArn",
        .metadata = "Metadata",
        .name = "Name",
    };
};
