/// Metadata assigned to an Amazon RDS resource consisting of a key-value pair.
///
/// For more information, see [Tagging Amazon RDS
/// resources](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/USER_Tagging.html) in the *Amazon RDS User Guide* or [Tagging Amazon Aurora and Amazon RDS resources](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_Tagging.html) in the *Amazon Aurora User Guide*.
pub const Tag = struct {
    /// A key is the required name of the tag. The string value can be from 1 to 128
    /// Unicode characters in length and can't be prefixed with `aws:` or `rds:`.
    /// The string can only contain only the set of Unicode letters, digits,
    /// white-space, '_', '.', ':', '/', '=', '+', '-', '@' (Java regex:
    /// "^([\\p{L}\\p{Z}\\p{N}_.:/=+\\-@]*)$").
    key: ?[]const u8,

    /// A value is the optional value of the tag. The string value can be from 1 to
    /// 256 Unicode characters in length and can't be prefixed with `aws:` or
    /// `rds:`. The string can only contain only the set of Unicode letters, digits,
    /// white-space, '_', '.', ':', '/', '=', '+', '-', '@' (Java regex:
    /// "^([\\p{L}\\p{Z}\\p{N}_.:/=+\\-@]*)$").
    value: ?[]const u8,
};
