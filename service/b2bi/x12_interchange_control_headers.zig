/// In X12, the Interchange Control Header is the first segment of an EDI
/// document and is part of the Interchange Envelope. It contains information
/// about the sender and receiver, the date and time of transmission, and the
/// X12 version being used. It also includes delivery information, such as the
/// sender and receiver IDs.
pub const X12InterchangeControlHeaders = struct {
    /// Located at position ISA-14 in the header. The value "1" indicates that the
    /// sender is requesting an interchange acknowledgment at receipt of the
    /// interchange. The value "0" is used otherwise.
    acknowledgment_requested_code: ?[]const u8,

    /// Located at position ISA-08 in the header. This value (along with the
    /// `receiverIdQualifier`) identifies the intended recipient of the interchange.
    receiver_id: ?[]const u8,

    /// Located at position ISA-07 in the header. Qualifier for the receiver ID.
    /// Together, the ID and qualifier uniquely identify the receiving trading
    /// partner.
    receiver_id_qualifier: ?[]const u8,

    /// Located at position ISA-11 in the header. This string makes it easier when
    /// you need to group similar adjacent element values together without using
    /// extra segments.
    ///
    /// This parameter is only honored for version greater than 401 (`VERSION_4010`
    /// and higher).
    ///
    /// For versions less than 401, this field is called
    /// [StandardsId](https://www.stedi.com/edi/x12-004010/segment/ISA#ISA-11), in
    /// which case our service sets the value to `U`.
    repetition_separator: ?[]const u8,

    /// Located at position ISA-06 in the header. This value (along with the
    /// `senderIdQualifier`) identifies the sender of the interchange.
    sender_id: ?[]const u8,

    /// Located at position ISA-05 in the header. Qualifier for the sender ID.
    /// Together, the ID and qualifier uniquely identify the sending trading
    /// partner.
    sender_id_qualifier: ?[]const u8,

    /// Located at position ISA-15 in the header. Specifies how this interchange is
    /// being used:
    ///
    /// * `T` indicates this interchange is for testing.
    /// * `P` indicates this interchange is for production.
    /// * `I` indicates this interchange is informational.
    usage_indicator_code: ?[]const u8,

    pub const json_field_names = .{
        .acknowledgment_requested_code = "acknowledgmentRequestedCode",
        .receiver_id = "receiverId",
        .receiver_id_qualifier = "receiverIdQualifier",
        .repetition_separator = "repetitionSeparator",
        .sender_id = "senderId",
        .sender_id_qualifier = "senderIdQualifier",
        .usage_indicator_code = "usageIndicatorCode",
    };
};
