const SensitiveDataItemCategory = @import("sensitive_data_item_category.zig").SensitiveDataItemCategory;

/// Provides information about a managed data identifier. For additional
/// information, see [Using managed data
/// identifiers](https://docs.aws.amazon.com/macie/latest/user/managed-data-identifiers.html) in the *Amazon Macie User Guide*.
pub const ManagedDataIdentifierSummary = struct {
    /// The category of sensitive data that the managed data identifier detects:
    /// CREDENTIALS, for credentials data such as private keys or Amazon Web
    /// Services secret access keys; FINANCIAL_INFORMATION, for financial data such
    /// as credit card numbers; or, PERSONAL_INFORMATION, for personal health
    /// information, such as health insurance identification numbers, or personally
    /// identifiable information, such as passport numbers.
    category: ?SensitiveDataItemCategory = null,

    /// The unique identifier for the managed data identifier. This is a string that
    /// describes the type of sensitive data that the managed data identifier
    /// detects. For example: OPENSSH_PRIVATE_KEY for OpenSSH private keys,
    /// CREDIT_CARD_NUMBER for credit card numbers, or USA_PASSPORT_NUMBER for US
    /// passport numbers.
    id: ?[]const u8 = null,

    pub const json_field_names = .{
        .category = "category",
        .id = "id",
    };
};
