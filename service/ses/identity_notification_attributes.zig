/// Represents the notification attributes of an identity, including whether an
/// identity
/// has Amazon Simple Notification Service (Amazon SNS) topics set for bounce,
/// complaint, and/or delivery notifications,
/// and whether feedback forwarding is enabled for bounce and complaint
/// notifications.
pub const IdentityNotificationAttributes = struct {
    /// The Amazon Resource Name (ARN) of the Amazon SNS topic where Amazon SES
    /// publishes bounce
    /// notifications.
    bounce_topic: []const u8,

    /// The Amazon Resource Name (ARN) of the Amazon SNS topic where Amazon SES
    /// publishes complaint
    /// notifications.
    complaint_topic: []const u8,

    /// The Amazon Resource Name (ARN) of the Amazon SNS topic where Amazon SES
    /// publishes delivery
    /// notifications.
    delivery_topic: []const u8,

    /// Describes whether Amazon SES forwards bounce and complaint notifications as
    /// email.
    /// `true` indicates that Amazon SES forwards bounce and complaint notifications
    /// as email, while `false` indicates that bounce and complaint notifications
    /// are
    /// published only to the specified bounce and complaint Amazon SNS topics.
    forwarding_enabled: bool = false,

    /// Describes whether Amazon SES includes the original email headers in Amazon
    /// SNS notifications of
    /// type `Bounce`. A value of `true` specifies that Amazon SES includes
    /// headers in bounce notifications, and a value of `false` specifies that
    /// Amazon SES
    /// does not include headers in bounce notifications.
    headers_in_bounce_notifications_enabled: bool = false,

    /// Describes whether Amazon SES includes the original email headers in Amazon
    /// SNS notifications of
    /// type `Complaint`. A value of `true` specifies that Amazon SES includes
    /// headers in complaint notifications, and a value of `false` specifies that
    /// Amazon SES does not include headers in complaint notifications.
    headers_in_complaint_notifications_enabled: bool = false,

    /// Describes whether Amazon SES includes the original email headers in Amazon
    /// SNS notifications of
    /// type `Delivery`. A value of `true` specifies that Amazon SES includes
    /// headers in delivery notifications, and a value of `false` specifies that
    /// Amazon SES does not include headers in delivery notifications.
    headers_in_delivery_notifications_enabled: bool = false,
};
