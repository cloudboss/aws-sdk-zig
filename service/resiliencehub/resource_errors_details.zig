const ResourceError = @import("resource_error.zig").ResourceError;

/// A list of errors retrieving an application's resources.
pub const ResourceErrorsDetails = struct {
    /// This indicates if there are more errors not listed in the `resourceErrors`
    /// list.
    has_more_errors: ?bool = null,

    /// A list of errors retrieving an application's resources.
    resource_errors: ?[]const ResourceError = null,

    pub const json_field_names = .{
        .has_more_errors = "hasMoreErrors",
        .resource_errors = "resourceErrors",
    };
};
