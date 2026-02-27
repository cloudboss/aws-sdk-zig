/// Contains details about an activity.
pub const ActivityListItem = struct {
    /// The Amazon Resource Name (ARN) that identifies the activity.
    activity_arn: []const u8,

    /// The date the activity is created.
    creation_date: i64,

    /// The name of the activity.
    ///
    /// A name must *not* contain:
    ///
    /// * white space
    ///
    /// * brackets ` { } [ ]`
    ///
    /// * wildcard characters `? *`
    ///
    /// * special characters `" # % \ ^ | ~ ` $ & , ; : /`
    ///
    /// * control characters (`U+0000-001F`, `U+007F-009F`, `U+FFFE-FFFF`)
    ///
    /// * surrogates (`U+D800-DFFF`)
    ///
    /// * invalid characters (` U+10FFFF`)
    ///
    /// To enable logging with CloudWatch Logs, the name should only contain 0-9,
    /// A-Z, a-z, - and _.
    name: []const u8,

    pub const json_field_names = .{
        .activity_arn = "activityArn",
        .creation_date = "creationDate",
        .name = "name",
    };
};
