/// The error object for representing failures in the
/// `BatchDeleteTaxRegistration`
/// operation.
pub const BatchDeleteTaxRegistrationError = struct {
    /// The unique account identifier for the account whose tax registration
    /// couldn't be deleted
    /// during the `BatchDeleteTaxRegistration` operation.
    account_id: []const u8,

    /// The error code for an individual failure in BatchDeleteTaxRegistration
    /// operation.
    code: ?[]const u8,

    /// The error message for an individual failure in the
    /// `BatchDeleteTaxRegistration` operation.
    message: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .code = "code",
        .message = "message",
    };
};
