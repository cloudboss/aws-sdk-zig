/// A certificate that has been transferred but not yet accepted.
pub const OutgoingCertificate = struct {
    /// The certificate ARN.
    certificate_arn: ?[]const u8 = null,

    /// The certificate ID.
    certificate_id: ?[]const u8 = null,

    /// The certificate creation date.
    creation_date: ?i64 = null,

    /// The date the transfer was initiated.
    transfer_date: ?i64 = null,

    /// The transfer message.
    transfer_message: ?[]const u8 = null,

    /// The Amazon Web Services account to which the transfer was made.
    transferred_to: ?[]const u8 = null,

    pub const json_field_names = .{
        .certificate_arn = "certificateArn",
        .certificate_id = "certificateId",
        .creation_date = "creationDate",
        .transfer_date = "transferDate",
        .transfer_message = "transferMessage",
        .transferred_to = "transferredTo",
    };
};
