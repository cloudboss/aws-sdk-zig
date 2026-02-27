const aws = @import("aws");

/// An extension that was invoked during a deployment.
pub const AppliedExtension = struct {
    /// The system-generated ID for the association.
    extension_association_id: ?[]const u8,

    /// The system-generated ID of the extension.
    extension_id: ?[]const u8,

    /// One or more parameters for the actions called by the extension.
    parameters: ?[]const aws.map.StringMapEntry,

    /// The extension version number.
    version_number: i32 = 0,

    pub const json_field_names = .{
        .extension_association_id = "ExtensionAssociationId",
        .extension_id = "ExtensionId",
        .parameters = "Parameters",
        .version_number = "VersionNumber",
    };
};
