/// The type of data identifier that detected a specific type of sensitive data
/// in an S3 bucket. Possible values are:
pub const DataIdentifierType = enum {
    custom,
    managed,

    pub const json_field_names = .{
        .custom = "CUSTOM",
        .managed = "MANAGED",
    };
};
