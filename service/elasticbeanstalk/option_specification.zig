/// A specification identifying an individual configuration option.
pub const OptionSpecification = struct {
    /// A unique namespace identifying the option's associated Amazon Web Services
    /// resource.
    namespace: ?[]const u8 = null,

    /// The name of the configuration option.
    option_name: ?[]const u8 = null,

    /// A unique resource name for a time-based scaling configuration option.
    resource_name: ?[]const u8 = null,
};
