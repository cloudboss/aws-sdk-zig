/// Specifies the allow lists, custom data identifiers, and managed data
/// identifiers to include (use) when performing automated sensitive data
/// discovery. The configuration must specify at least one custom data
/// identifier or managed data identifier. For information about the managed
/// data identifiers that Amazon Macie currently provides, see [Using managed
/// data
/// identifiers](https://docs.aws.amazon.com/macie/latest/user/managed-data-identifiers.html) in the *Amazon Macie User Guide*.
pub const SensitivityInspectionTemplateIncludes = struct {
    /// An array of unique identifiers, one for each allow list to include.
    allow_list_ids: ?[]const []const u8,

    /// An array of unique identifiers, one for each custom data identifier to
    /// include.
    custom_data_identifier_ids: ?[]const []const u8,

    /// An array of unique identifiers, one for each managed data identifier to
    /// include.
    ///
    /// Amazon Macie uses these managed data identifiers in addition to managed data
    /// identifiers that are subsequently released and recommended for automated
    /// sensitive data discovery. To retrieve a list of valid values for the managed
    /// data identifiers that are currently available, use the
    /// ListManagedDataIdentifiers operation.
    managed_data_identifier_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .allow_list_ids = "allowListIds",
        .custom_data_identifier_ids = "customDataIdentifierIds",
        .managed_data_identifier_ids = "managedDataIdentifierIds",
    };
};
