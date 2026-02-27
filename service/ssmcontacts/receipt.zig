const ReceiptType = @import("receipt_type.zig").ReceiptType;

/// Records events during an engagement.
pub const Receipt = struct {
    /// The Amazon Resource Name (ARN) of the contact channel Incident Manager
    /// engaged.
    contact_channel_arn: ?[]const u8,

    /// Information provided during the page acknowledgement.
    receipt_info: ?[]const u8,

    /// The time receipt was `SENT`, `DELIVERED`, or
    /// `READ`.
    receipt_time: i64,

    /// The type follows the engagement cycle, `SENT`, `DELIVERED`, and
    /// `READ`.
    receipt_type: ReceiptType,

    pub const json_field_names = .{
        .contact_channel_arn = "ContactChannelArn",
        .receipt_info = "ReceiptInfo",
        .receipt_time = "ReceiptTime",
        .receipt_type = "ReceiptType",
    };
};
