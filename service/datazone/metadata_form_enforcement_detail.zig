const MetadataFormReference = @import("metadata_form_reference.zig").MetadataFormReference;

/// The enforcement details of a metadata form.
pub const MetadataFormEnforcementDetail = struct {
    /// The required metadata forms.
    required_metadata_forms: ?[]const MetadataFormReference,

    pub const json_field_names = .{
        .required_metadata_forms = "requiredMetadataForms",
    };
};
