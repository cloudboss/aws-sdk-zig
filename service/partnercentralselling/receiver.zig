const AccountReceiver = @import("account_receiver.zig").AccountReceiver;

/// Represents the entity that received the Engagement Invitation, including
/// account and company details. This field is essential for tracking the
/// partner who is being invited to collaborate.
pub const Receiver = union(enum) {
    /// Specifies the AWS account of the partner who received the Engagement
    /// Invitation. This field is used to track the invitation recipient within the
    /// AWS ecosystem.
    account: ?AccountReceiver,

    pub const json_field_names = .{
        .account = "Account",
    };
};
