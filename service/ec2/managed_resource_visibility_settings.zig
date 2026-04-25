const ManagedResourceDefaultVisibility = @import("managed_resource_default_visibility.zig").ManagedResourceDefaultVisibility;

/// Describes the managed resource visibility settings for the account.
pub const ManagedResourceVisibilitySettings = struct {
    /// The default visibility setting for managed resources. A value of
    /// `hidden` indicates that managed resources are not included in Describe
    /// operation responses by default. A value of `visible` indicates that managed
    /// resources are included by default.
    default_visibility: ?ManagedResourceDefaultVisibility = null,
};
