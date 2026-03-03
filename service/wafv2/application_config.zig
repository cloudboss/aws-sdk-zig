const ApplicationAttribute = @import("application_attribute.zig").ApplicationAttribute;

/// A list of `ApplicationAttribute`s that contains information about the
/// application.
pub const ApplicationConfig = struct {
    /// Contains the attribute name and a list of values for that attribute.
    attributes: ?[]const ApplicationAttribute = null,

    pub const json_field_names = .{
        .attributes = "Attributes",
    };
};
