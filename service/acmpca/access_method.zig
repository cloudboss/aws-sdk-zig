const AccessMethodType = @import("access_method_type.zig").AccessMethodType;

/// Describes the type and format of extension access. Only one of
/// `CustomObjectIdentifier` or `AccessMethodType` may be provided. Providing
/// both results in `InvalidArgsException`.
pub const AccessMethod = struct {
    /// Specifies the `AccessMethod`.
    access_method_type: ?AccessMethodType,

    /// An object identifier (OID) specifying the `AccessMethod`. The OID must
    /// satisfy the regular expression shown below. For more information, see NIST's
    /// definition of [Object Identifier
    /// (OID)](https://csrc.nist.gov/glossary/term/Object_Identifier).
    custom_object_identifier: ?[]const u8,

    pub const json_field_names = .{
        .access_method_type = "AccessMethodType",
        .custom_object_identifier = "CustomObjectIdentifier",
    };
};
