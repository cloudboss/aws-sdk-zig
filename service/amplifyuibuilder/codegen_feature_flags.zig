/// Describes the feature flags that you can specify for a code generation job.
pub const CodegenFeatureFlags = struct {
    /// Specifies whether a code generation job supports non models.
    is_non_model_supported: ?bool = null,

    /// Specifes whether a code generation job supports data relationships.
    is_relationship_supported: ?bool = null,

    pub const json_field_names = .{
        .is_non_model_supported = "isNonModelSupported",
        .is_relationship_supported = "isRelationshipSupported",
    };
};
