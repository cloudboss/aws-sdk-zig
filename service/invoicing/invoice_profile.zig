const ReceiverAddress = @import("receiver_address.zig").ReceiverAddress;

/// Contains high-level information about the invoice receiver.
pub const InvoiceProfile = struct {
    /// The account ID the invoice profile is generated for.
    account_id: ?[]const u8 = null,

    /// This specifies the issuing entity of the invoice.
    issuer: ?[]const u8 = null,

    /// The address of the receiver that will be printed on the invoice.
    receiver_address: ?ReceiverAddress = null,

    /// The email address for the invoice profile receiver.
    receiver_email: ?[]const u8 = null,

    /// The name of the person receiving the invoice profile.
    receiver_name: ?[]const u8 = null,

    /// Your Tax Registration Number (TRN) information.
    tax_registration_number: ?[]const u8 = null,

    pub const json_field_names = .{
        .account_id = "AccountId",
        .issuer = "Issuer",
        .receiver_address = "ReceiverAddress",
        .receiver_email = "ReceiverEmail",
        .receiver_name = "ReceiverName",
        .tax_registration_number = "TaxRegistrationNumber",
    };
};
