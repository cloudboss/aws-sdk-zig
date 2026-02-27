/// A framework supported by the platform.
pub const PlatformFramework = struct {
    /// The name of the framework.
    name: ?[]const u8,

    /// The version of the framework.
    version: ?[]const u8,
};
