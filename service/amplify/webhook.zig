/// Describes a webhook that connects repository events to an Amplify app.
pub const Webhook = struct {
    /// The unique ID of an Amplify app.
    app_id: ?[]const u8 = null,

    /// The name for a branch that is part of an Amplify app.
    branch_name: []const u8,

    /// A timestamp of when Amplify created the webhook in your Git
    /// repository.
    create_time: i64,

    /// The description for a webhook.
    description: []const u8,

    /// A timestamp of when Amplify updated the webhook in your Git
    /// repository.
    update_time: i64,

    /// The Amazon Resource Name (ARN) for the webhook.
    webhook_arn: []const u8,

    /// The ID of the webhook.
    webhook_id: []const u8,

    /// The URL of the webhook.
    webhook_url: []const u8,

    pub const json_field_names = .{
        .app_id = "appId",
        .branch_name = "branchName",
        .create_time = "createTime",
        .description = "description",
        .update_time = "updateTime",
        .webhook_arn = "webhookArn",
        .webhook_id = "webhookId",
        .webhook_url = "webhookUrl",
    };
};
