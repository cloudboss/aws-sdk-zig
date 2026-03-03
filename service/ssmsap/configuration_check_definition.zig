const ApplicationType = @import("application_type.zig").ApplicationType;
const ConfigurationCheckType = @import("configuration_check_type.zig").ConfigurationCheckType;

/// Represents a configuration check definition supported by AWS Systems Manager
/// for SAP.
pub const ConfigurationCheckDefinition = struct {
    /// The list of SSMSAP application types that this configuration check can be
    /// evaluated against.
    applicable_application_types: ?[]const ApplicationType = null,

    /// A description of what the configuration check validates.
    description: ?[]const u8 = null,

    /// The unique identifier of the configuration check.
    id: ?ConfigurationCheckType = null,

    /// The name of the configuration check.
    name: ?[]const u8 = null,

    pub const json_field_names = .{
        .applicable_application_types = "ApplicableApplicationTypes",
        .description = "Description",
        .id = "Id",
        .name = "Name",
    };
};
