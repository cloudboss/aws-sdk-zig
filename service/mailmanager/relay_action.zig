const ActionFailurePolicy = @import("action_failure_policy.zig").ActionFailurePolicy;
const MailFrom = @import("mail_from.zig").MailFrom;

/// The action relays the email via SMTP to another specific SMTP server.
pub const RelayAction = struct {
    /// A policy that states what to do in the case of failure. The action will fail
    /// if there are configuration errors. For example, the specified relay has been
    /// deleted.
    action_failure_policy: ?ActionFailurePolicy,

    /// This action specifies whether to preserve or replace original mail from
    /// address while relaying received emails to a destination server.
    mail_from: ?MailFrom,

    /// The identifier of the relay resource to be used when relaying an email.
    relay: []const u8,

    pub const json_field_names = .{
        .action_failure_policy = "ActionFailurePolicy",
        .mail_from = "MailFrom",
        .relay = "Relay",
    };
};
