/// The type of delivery events:
///
/// * `SEND` - The send request was successful and SES will
/// attempt to deliver the message to the recipient’s mail server. (If
/// account-level
/// or global suppression is being used, SES will still count it as a send,
/// but delivery is suppressed.)
///
/// * `DELIVERY` - SES successfully delivered the email to the
/// recipient's mail server. Excludes deliveries to the mailbox simulator and
/// emails addressed to more than one recipient.
///
/// * `TRANSIENT_BOUNCE` - Feedback received for
/// delivery failures excluding issues with non-existent mailboxes. Excludes
/// bounces from the
/// mailbox simulator, and those from emails addressed to more than one
/// recipient.
///
/// * `PERMANENT_BOUNCE` - Feedback received for
/// emails sent to non-existent mailboxes. Excludes bounces from the mailbox
/// simulator, those
/// originating from your account-level suppression list (if enabled), and those
/// from emails
/// addressed to more than one recipient.
///
/// * `UNDETERMINED_BOUNCE` - SES was unable to determine the bounce reason.
///
/// * `COMPLAINT` - Complaint received for the email.
/// This excludes complaints from the mailbox simulator, those originating from
/// your account-level suppression list (if enabled), and those from emails
/// addressed to more
/// than one recipient.
pub const DeliveryEventType = enum {
    send,
    delivery,
    transient_bounce,
    permanent_bounce,
    undetermined_bounce,
    complaint,

    pub const json_field_names = .{
        .send = "SEND",
        .delivery = "DELIVERY",
        .transient_bounce = "TRANSIENT_BOUNCE",
        .permanent_bounce = "PERMANENT_BOUNCE",
        .undetermined_bounce = "UNDETERMINED_BOUNCE",
        .complaint = "COMPLAINT",
    };
};
