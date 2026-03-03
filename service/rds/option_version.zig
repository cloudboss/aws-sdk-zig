/// The version for an option. Option group option versions are returned by the
/// `DescribeOptionGroupOptions` action.
pub const OptionVersion = struct {
    /// Indicates whether the version is the default version of the option.
    is_default: ?bool = null,

    /// The version of the option.
    version: ?[]const u8 = null,
};
