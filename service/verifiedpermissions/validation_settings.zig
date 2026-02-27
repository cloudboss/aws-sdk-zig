const ValidationMode = @import("validation_mode.zig").ValidationMode;

/// A structure that contains Cedar policy validation settings for the policy
/// store. The validation mode determines which validation failures that Cedar
/// considers serious enough to block acceptance of a new or edited static
/// policy or policy template.
///
/// This data type is used as a request parameter in the
/// [CreatePolicyStore](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_CreatePolicyStore.html) and [UpdatePolicyStore](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_UpdatePolicyStore.html) operations.
pub const ValidationSettings = struct {
    /// The validation mode currently configured for this policy store. The valid
    /// values are:
    ///
    /// * **OFF** – Neither Verified Permissions nor Cedar perform any validation on
    ///   policies. No validation errors are reported by either service.
    /// * **STRICT** – Requires a schema to be present in the policy store. Cedar
    ///   performs validation on all submitted new or updated static policies and
    ///   policy templates. Any that fail validation are rejected and Cedar doesn't
    ///   store them in the policy store.
    ///
    /// If `Mode=STRICT` and the policy store doesn't contain a schema, Verified
    /// Permissions rejects all static policies and policy templates because there
    /// is no schema to validate against.
    ///
    /// To submit a static policy or policy template without a schema, you must turn
    /// off validation.
    mode: ValidationMode,

    pub const json_field_names = .{
        .mode = "mode",
    };
};
