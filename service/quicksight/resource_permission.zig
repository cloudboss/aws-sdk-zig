/// Permission for the resource.
pub const ResourcePermission = struct {
    /// The IAM action to grant or revoke permissions on.
    actions: []const []const u8,

    /// The Amazon Resource Name (ARN) of the principal. This can be one of the
    /// following:
    ///
    /// * The ARN of an Quick Sight user or group associated with a data source or
    ///   dataset. (This is common.)
    ///
    /// * The ARN of an Quick Sight user, group, or namespace associated with an
    ///   analysis, dashboard, template, or theme. Namespace sharing is not
    ///   supported for action connectors. (This is common.)
    ///
    /// * The ARN of an Amazon Web Services account root: This is an IAM ARN rather
    ///   than a Quick Sight
    /// ARN. Use this option only to share resources (templates) across Amazon Web
    /// Services accounts. Account root sharing is not supported for action
    /// connectors.
    /// (This is less common.)
    principal: []const u8,

    pub const json_field_names = .{
        .actions = "Actions",
        .principal = "Principal",
    };
};
