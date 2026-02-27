const SubscribedGroupInput = @import("subscribed_group_input.zig").SubscribedGroupInput;
const SubscribedIamPrincipalInput = @import("subscribed_iam_principal_input.zig").SubscribedIamPrincipalInput;
const SubscribedProjectInput = @import("subscribed_project_input.zig").SubscribedProjectInput;
const SubscribedUserInput = @import("subscribed_user_input.zig").SubscribedUserInput;

/// The principal that is to be given a subscriptiong grant.
pub const SubscribedPrincipalInput = union(enum) {
    /// The subscribed group.
    group: ?SubscribedGroupInput,
    /// The subscribed IAM principal.
    iam: ?SubscribedIamPrincipalInput,
    /// The project that is to be given a subscription grant.
    project: ?SubscribedProjectInput,
    /// The subscribed user.
    user: ?SubscribedUserInput,

    pub const json_field_names = .{
        .group = "group",
        .iam = "iam",
        .project = "project",
        .user = "user",
    };
};
