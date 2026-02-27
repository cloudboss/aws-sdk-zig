/// Information about an association between an extension and an AppConfig
/// resource such as an application, environment, or configuration profile. Call
/// `GetExtensionAssociation` to get more information about an
/// association.
pub const ExtensionAssociationSummary = struct {
    /// The system-generated Amazon Resource Name (ARN) for the extension.
    extension_arn: ?[]const u8,

    /// The extension association ID. This ID is used to call other
    /// `ExtensionAssociation` API actions such as
    /// `GetExtensionAssociation` or `DeleteExtensionAssociation`.
    id: ?[]const u8,

    /// The ARNs of applications, configuration profiles, or environments defined in
    /// the
    /// association.
    resource_arn: ?[]const u8,

    pub const json_field_names = .{
        .extension_arn = "ExtensionArn",
        .id = "Id",
        .resource_arn = "ResourceArn",
    };
};
