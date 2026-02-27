const InternalAccessConfiguration = @import("internal_access_configuration.zig").InternalAccessConfiguration;
const UnusedAccessConfiguration = @import("unused_access_configuration.zig").UnusedAccessConfiguration;

/// Contains information about the configuration of an analyzer for an Amazon
/// Web Services organization or account.
pub const AnalyzerConfiguration = union(enum) {
    /// Specifies the configuration of an internal access analyzer for an Amazon Web
    /// Services organization or account. This configuration determines how the
    /// analyzer evaluates access within your Amazon Web Services environment.
    internal_access: ?InternalAccessConfiguration,
    /// Specifies the configuration of an unused access analyzer for an Amazon Web
    /// Services organization or account.
    unused_access: ?UnusedAccessConfiguration,

    pub const json_field_names = .{
        .internal_access = "internalAccess",
        .unused_access = "unusedAccess",
    };
};
