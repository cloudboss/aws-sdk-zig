/// A specification identifying an individual configuration option.
pub const OptionSpecification = struct {
    /// A unique namespace identifying the option's associated AWS resource.
    namespace: ?[]const u8,

    /// The name of the configuration option.
    option_name: ?[]const u8,

    /// A unique resource name for a time-based scaling configuration option.
    resource_name: ?[]const u8,
};
