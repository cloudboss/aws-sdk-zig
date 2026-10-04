/// A reference to a form type that is included in an asset type.
pub const AssetTypeFormReference = struct {
    /// The identifier of the referenced form type.
    form_type_identifier: []const u8,

    pub const json_field_names = .{
        .form_type_identifier = "FormTypeIdentifier",
    };
};
