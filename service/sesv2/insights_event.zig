const EventDetails = @import("event_details.zig").EventDetails;
const EventType = @import("event_type.zig").EventType;

/// An object containing details about a specific event.
pub const InsightsEvent = struct {
    /// Details about bounce or complaint events.
    details: ?EventDetails = null,

    /// The timestamp of the event.
    timestamp: ?i64 = null,

    /// The type of event:
    ///
    /// * `SEND` - The send request was successful and SES will
    /// attempt to deliver the message to the recipient’s mail server. (If
    /// account-level
    /// or global suppression is being used, SES will still count it as a send,
    /// but delivery is suppressed.)
    ///
    /// * `DELIVERY` - SES successfully delivered the email to the
    /// recipient's mail server. Excludes deliveries to the mailbox simulator,
    /// and those from emails addressed to more than one recipient.
    ///
    /// * `BOUNCE` - Feedback received for delivery failures. Additional details
    ///   about the bounce are provided in the `Details` object.
    /// Excludes bounces from the mailbox simulator, and those from emails addressed
    /// to more than one recipient.
    ///
    /// * `COMPLAINT` - Complaint received for the email. Additional details about
    ///   the complaint are provided in the `Details` object.
    /// This excludes complaints from the mailbox simulator, those originating from
    /// your account-level suppression list (if enabled), and those from emails
    /// addressed
    /// to more than one recipient.
    ///
    /// * `OPEN` - Open event for emails including open trackers.
    /// Excludes opens for emails addressed to more than one recipient.
    ///
    /// * `CLICK` - Click event for emails including wrapped links.
    /// Excludes clicks for emails addressed to more than one recipient.
    @"type": ?EventType = null,

    pub const json_field_names = .{
        .details = "Details",
        .timestamp = "Timestamp",
        .@"type" = "Type",
    };
};
