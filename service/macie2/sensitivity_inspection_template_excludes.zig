/// Specifies managed data identifiers to exclude (not use) when performing
/// automated sensitive data discovery. For information about the managed data
/// identifiers that Amazon Macie currently provides, see [Using managed data
/// identifiers](https://docs.aws.amazon.com/macie/latest/user/managed-data-identifiers.html) in the *Amazon Macie User Guide*.
pub const SensitivityInspectionTemplateExcludes = struct {
    /// An array of unique identifiers, one for each managed data identifier to
    /// exclude. To retrieve a list of valid values, use the
    /// ListManagedDataIdentifiers operation.
    managed_data_identifier_ids: ?[]const []const u8,

    pub const json_field_names = .{
        .managed_data_identifier_ids = "managedDataIdentifierIds",
    };
};
