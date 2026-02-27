const AddHeaderAction = @import("add_header_action.zig").AddHeaderAction;
const ArchiveAction = @import("archive_action.zig").ArchiveAction;
const DeliverToMailboxAction = @import("deliver_to_mailbox_action.zig").DeliverToMailboxAction;
const DeliverToQBusinessAction = @import("deliver_to_q_business_action.zig").DeliverToQBusinessAction;
const DropAction = @import("drop_action.zig").DropAction;
const SnsAction = @import("sns_action.zig").SnsAction;
const RelayAction = @import("relay_action.zig").RelayAction;
const ReplaceRecipientAction = @import("replace_recipient_action.zig").ReplaceRecipientAction;
const SendAction = @import("send_action.zig").SendAction;
const S3Action = @import("s3_action.zig").S3Action;

/// The action for a rule to take. Only one of the contained actions can be set.
pub const RuleAction = union(enum) {
    /// This action adds a header. This can be used to add arbitrary email headers.
    add_header: ?AddHeaderAction,
    /// This action archives the email. This can be used to deliver an email to an
    /// archive.
    archive: ?ArchiveAction,
    /// This action delivers an email to a WorkMail mailbox.
    deliver_to_mailbox: ?DeliverToMailboxAction,
    /// This action delivers an email to an Amazon Q Business application for
    /// ingestion into its knowledge base.
    deliver_to_q_business: ?DeliverToQBusinessAction,
    /// This action terminates the evaluation of rules in the rule set.
    drop: ?DropAction,
    /// This action publishes the email content to an Amazon SNS topic.
    publish_to_sns: ?SnsAction,
    /// This action relays the email to another SMTP server.
    relay: ?RelayAction,
    /// The action replaces certain or all recipients with a different set of
    /// recipients.
    replace_recipient: ?ReplaceRecipientAction,
    /// This action sends the email to the internet.
    send: ?SendAction,
    /// This action writes the MIME content of the email to an S3 bucket.
    write_to_s3: ?S3Action,

    pub const json_field_names = .{
        .add_header = "AddHeader",
        .archive = "Archive",
        .deliver_to_mailbox = "DeliverToMailbox",
        .deliver_to_q_business = "DeliverToQBusiness",
        .drop = "Drop",
        .publish_to_sns = "PublishToSns",
        .relay = "Relay",
        .replace_recipient = "ReplaceRecipient",
        .send = "Send",
        .write_to_s3 = "WriteToS3",
    };
};
