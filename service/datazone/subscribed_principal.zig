const SubscribedGroup = @import("subscribed_group.zig").SubscribedGroup;
const SubscribedIamPrincipal = @import("subscribed_iam_principal.zig").SubscribedIamPrincipal;
const SubscribedProject = @import("subscribed_project.zig").SubscribedProject;
const SubscribedUser = @import("subscribed_user.zig").SubscribedUser;

/// The principal that has the subscription grant for the asset.
pub const SubscribedPrincipal = union(enum) {
    /// The subscribed group.
    group: ?SubscribedGroup,
    /// The subscribed IAM principal.
    iam: ?SubscribedIamPrincipal,
    /// The project that has the subscription grant.
    project: ?SubscribedProject,
    /// The subscribed user.
    user: ?SubscribedUser,

    pub const json_field_names = .{
        .group = "group",
        .iam = "iam",
        .project = "project",
        .user = "user",
    };
};
