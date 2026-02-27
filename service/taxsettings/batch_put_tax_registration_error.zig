/// The error object for representing failures in the `BatchPutTaxRegistration`
/// operation.
pub const BatchPutTaxRegistrationError = struct {
    /// The unique account identifier for the account that the tax registration
    /// couldn't be
    /// added, or updated during the `BatchPutTaxRegistration` operation.
    account_id: []const u8,

    /// The error code for an individual failure in the `BatchPutTaxRegistration`
    /// operation.
    code: ?[]const u8,

    /// The error message for an individual failure in the `BatchPutTaxRegistration`
    /// operation.
    message: []const u8,

    pub const json_field_names = .{
        .account_id = "accountId",
        .code = "code",
        .message = "message",
    };
};
