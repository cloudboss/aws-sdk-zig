const RegistrationTypeDisplayHints = @import("registration_type_display_hints.zig").RegistrationTypeDisplayHints;
const SupportedAssociation = @import("supported_association.zig").SupportedAssociation;

/// Provides information on the supported registration type.
pub const RegistrationTypeDefinition = struct {
    /// Provides help information on the registration.
    display_hints: RegistrationTypeDisplayHints,

    /// The type of registration form. The list of **RegistrationTypes** can be
    /// found using the DescribeRegistrationTypeDefinitions action.
    registration_type: []const u8,

    /// The supported association behavior for the registration type.
    supported_associations: ?[]const SupportedAssociation,

    pub const json_field_names = .{
        .display_hints = "DisplayHints",
        .registration_type = "RegistrationType",
        .supported_associations = "SupportedAssociations",
    };
};
