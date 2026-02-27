/// The settings for client-side encryption for cryptographic computing.
pub const DataEncryptionMetadata = struct {
    /// Indicates whether encrypted tables can contain cleartext data (`TRUE`) or
    /// are to cryptographically process every column (`FALSE`).
    allow_cleartext: bool,

    /// Indicates whether Fingerprint columns can contain duplicate entries (`TRUE`)
    /// or are to contain only non-repeated values (`FALSE`).
    allow_duplicates: bool,

    /// Indicates whether Fingerprint columns can be joined on any other Fingerprint
    /// column with a different name (`TRUE`) or can only be joined on Fingerprint
    /// columns of the same name (`FALSE`).
    allow_joins_on_columns_with_different_names: bool,

    /// Indicates whether NULL values are to be copied as NULL to encrypted tables
    /// (`TRUE`) or cryptographically processed (`FALSE`).
    preserve_nulls: bool,

    pub const json_field_names = .{
        .allow_cleartext = "allowCleartext",
        .allow_duplicates = "allowDuplicates",
        .allow_joins_on_columns_with_different_names = "allowJoinsOnColumnsWithDifferentNames",
        .preserve_nulls = "preserveNulls",
    };
};
