/// Contains a list of principal types, resource types, and actions that can be
/// specified in policies stored in the same policy store. If the validation
/// mode for the policy store is set to `STRICT`, then policies that can't be
/// validated by this schema are rejected by Verified Permissions and can't be
/// stored in the policy store.
pub const SchemaDefinition = union(enum) {
    /// A JSON string representation of the schema supported by applications that
    /// use this policy store. To delete the schema, run
    /// [PutSchema](https://docs.aws.amazon.com/verifiedpermissions/latest/apireference/API_PutSchema.html) with `{}` for this parameter. For more information, see [Policy store schema](https://docs.aws.amazon.com/verifiedpermissions/latest/userguide/schema.html) in the *Amazon Verified Permissions User Guide*.
    cedar_json: ?[]const u8,

    pub const json_field_names = .{
        .cedar_json = "cedarJson",
    };
};
