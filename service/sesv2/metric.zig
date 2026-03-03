const std = @import("std");

/// The metric to export, can be one of the following:
///
/// * `SEND` - Emails sent eligible for tracking in the VDM
/// dashboard. This excludes emails sent to the mailbox simulator and emails
/// addressed to more than one recipient.
///
/// * `COMPLAINT` - Complaints received for your account. This
/// excludes complaints from the mailbox simulator, those originating from your
/// account-level suppression list (if enabled), and those for emails addressed
/// to
/// more than one recipient
///
/// * `PERMANENT_BOUNCE` - Permanent bounces - i.e., feedback
/// received for emails sent to non-existent mailboxes. Excludes bounces from
/// the
/// mailbox simulator, those originating from your account-level suppression
/// list
/// (if enabled), and those for emails addressed to more than one recipient.
///
/// * `TRANSIENT_BOUNCE` - Transient bounces - i.e., feedback
/// received for delivery failures excluding issues with non-existent mailboxes.
/// Excludes bounces from the mailbox simulator, and those for emails addressed
/// to
/// more than one recipient.
///
/// * `OPEN` - Unique open events for emails including open
/// trackers. Excludes opens for emails addressed to more than one recipient.
///
/// * `CLICK` - Unique click events for emails including wrapped
/// links. Excludes clicks for emails addressed to more than one recipient.
///
/// * `DELIVERY` - Successful deliveries for email sending
/// attempts. Excludes deliveries to the mailbox simulator and for emails
/// addressed
/// to more than one recipient.
///
/// * `DELIVERY_OPEN` - Successful deliveries for email sending
/// attempts. Excludes deliveries to the mailbox simulator, for emails addressed
/// to
/// more than one recipient, and emails without open trackers.
///
/// * `DELIVERY_CLICK` - Successful deliveries for email sending
/// attempts. Excludes deliveries to the mailbox simulator, for emails addressed
/// to
/// more than one recipient, and emails without click trackers.
///
/// * `DELIVERY_COMPLAINT` - Successful deliveries for email
/// sending attempts. Excludes deliveries to the mailbox simulator, for emails
/// addressed to more than one recipient, and emails addressed to recipients
/// hosted
/// by ISPs with which Amazon SES does not have a feedback loop agreement.
pub const Metric = enum {
    send,
    complaint,
    permanent_bounce,
    transient_bounce,
    open,
    click,
    delivery,
    delivery_open,
    delivery_click,
    delivery_complaint,

    pub const json_field_names = .{
        .send = "SEND",
        .complaint = "COMPLAINT",
        .permanent_bounce = "PERMANENT_BOUNCE",
        .transient_bounce = "TRANSIENT_BOUNCE",
        .open = "OPEN",
        .click = "CLICK",
        .delivery = "DELIVERY",
        .delivery_open = "DELIVERY_OPEN",
        .delivery_click = "DELIVERY_CLICK",
        .delivery_complaint = "DELIVERY_COMPLAINT",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .send => "SEND",
            .complaint => "COMPLAINT",
            .permanent_bounce => "PERMANENT_BOUNCE",
            .transient_bounce => "TRANSIENT_BOUNCE",
            .open => "OPEN",
            .click => "CLICK",
            .delivery => "DELIVERY",
            .delivery_open => "DELIVERY_OPEN",
            .delivery_click => "DELIVERY_CLICK",
            .delivery_complaint => "DELIVERY_COMPLAINT",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
