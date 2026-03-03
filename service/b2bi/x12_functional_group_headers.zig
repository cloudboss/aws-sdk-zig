/// Part of the X12 message structure. These are the functional group headers
/// for the X12 EDI object.
pub const X12FunctionalGroupHeaders = struct {
    /// A value representing the code used to identify the party receiving a
    /// message, at position GS-03.
    application_receiver_code: ?[]const u8 = null,

    /// A value representing the code used to identify the party transmitting a
    /// message, at position GS-02.
    application_sender_code: ?[]const u8 = null,

    /// A code that identifies the issuer of the standard, at position GS-07.
    responsible_agency_code: ?[]const u8 = null,

    pub const json_field_names = .{
        .application_receiver_code = "applicationReceiverCode",
        .application_sender_code = "applicationSenderCode",
        .responsible_agency_code = "responsibleAgencyCode",
    };
};
