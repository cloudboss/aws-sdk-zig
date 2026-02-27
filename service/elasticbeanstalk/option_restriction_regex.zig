/// A regular expression representing a restriction on a string configuration
/// option
/// value.
pub const OptionRestrictionRegex = struct {
    /// A unique name representing this regular expression.
    label: ?[]const u8,

    /// The regular expression pattern that a string configuration option value with
    /// this
    /// restriction must match.
    pattern: ?[]const u8,
};
