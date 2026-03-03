/// Additional tax information to specify for a TRN in Vietnam.
pub const VietnamAdditionalInfo = struct {
    /// The electronic transaction code number on the tax return document. This
    /// field must be provided for successful API operation.
    electronic_transaction_code_number: ?[]const u8 = null,

    /// The enterprise identification number for tax registration. This field must
    /// be provided for successful API operation.
    enterprise_identification_number: ?[]const u8 = null,

    /// The payment voucher number on the tax return payment document. This field
    /// must be provided for successful API operation.
    payment_voucher_number: ?[]const u8 = null,

    /// The date on the tax return payment document. This field must be provided for
    /// successful API operation.
    payment_voucher_number_date: ?[]const u8 = null,

    pub const json_field_names = .{
        .electronic_transaction_code_number = "electronicTransactionCodeNumber",
        .enterprise_identification_number = "enterpriseIdentificationNumber",
        .payment_voucher_number = "paymentVoucherNumber",
        .payment_voucher_number_date = "paymentVoucherNumberDate",
    };
};
