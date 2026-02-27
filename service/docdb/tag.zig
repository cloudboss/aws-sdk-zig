/// Metadata assigned to an Amazon DocumentDB resource consisting of a key-value
/// pair.
pub const Tag = struct {
    /// The required name of the tag. The string value can be from 1 to 128 Unicode
    /// characters in length and can't be prefixed with "`aws:`" or "`rds:`". The
    /// string can contain only the set of Unicode letters, digits, white space,
    /// '_', '.', '/', '=', '+', '-' (Java regex:
    /// "^([\\p{L}\\p{Z}\\p{N}_.:/=+\\-]*)$").
    key: ?[]const u8,

    /// The optional value of the tag. The string value can be from 1 to 256 Unicode
    /// characters in length and can't be prefixed with "`aws:`" or "`rds:`". The
    /// string can contain only the set of Unicode letters, digits, white space,
    /// '_', '.', '/', '=', '+', '-' (Java regex:
    /// "^([\\p{L}\\p{Z}\\p{N}_.:/=+\\-]*)$").
    value: ?[]const u8,
};
