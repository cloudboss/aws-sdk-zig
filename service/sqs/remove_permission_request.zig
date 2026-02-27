pub const RemovePermissionRequest = struct {
    /// The identification of the permission to remove. This is the label added
    /// using the
    /// `
    /// AddPermission
    /// ` action.
    label: []const u8,

    /// The URL of the Amazon SQS queue from which permissions are removed.
    ///
    /// Queue URLs and names are case-sensitive.
    queue_url: []const u8,

    pub const json_field_names = .{
        .label = "Label",
        .queue_url = "QueueUrl",
    };
};
