/// An Amazon Q App associated with a user, either owned by the user or
/// favorited.
pub const UserAppItem = struct {
    /// The Amazon Resource Name (ARN) of the Q App.
    app_arn: []const u8,

    /// The unique identifier of the Q App.
    app_id: []const u8,

    /// A flag indicating whether the user can edit the Q App.
    can_edit: ?bool,

    /// The date and time the user's association with the Q App was created.
    created_at: i64,

    /// The description of the Q App.
    description: ?[]const u8,

    /// Indicates whether the Q App has been verified.
    is_verified: bool = false,

    /// The status of the user's association with the Q App.
    status: ?[]const u8,

    /// The title of the Q App.
    title: []const u8,

    pub const json_field_names = .{
        .app_arn = "appArn",
        .app_id = "appId",
        .can_edit = "canEdit",
        .created_at = "createdAt",
        .description = "description",
        .is_verified = "isVerified",
        .status = "status",
        .title = "title",
    };
};
