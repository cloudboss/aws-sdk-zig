const LocalNavigationConfiguration = @import("local_navigation_configuration.zig").LocalNavigationConfiguration;

/// The navigation operation that navigates between different sheets in the same
/// analysis.
///
/// This is a union type structure. For this structure to be valid, only one of
/// the attributes can be defined.
pub const CustomActionNavigationOperation = struct {
    /// The configuration that chooses the navigation target.
    local_navigation_configuration: ?LocalNavigationConfiguration,

    pub const json_field_names = .{
        .local_navigation_configuration = "LocalNavigationConfiguration",
    };
};
