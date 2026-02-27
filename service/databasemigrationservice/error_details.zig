const DefaultErrorDetails = @import("default_error_details.zig").DefaultErrorDetails;

/// Provides error information about a project.
pub const ErrorDetails = union(enum) {
    /// Error information about a project.
    default_error_details: ?DefaultErrorDetails,

    pub const json_field_names = .{
        .default_error_details = "defaultErrorDetails",
    };
};
