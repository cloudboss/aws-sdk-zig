/// The name and status of a customer agreement.
pub const CustomerAgreement = struct {
    /// The name of the agreement.
    agreement_name: ?[]const u8,

    /// The status of the customer agreement. This will be either `signed` or
    /// `unsigned`
    status: ?[]const u8,

    pub const json_field_names = .{
        .agreement_name = "agreementName",
        .status = "status",
    };
};
