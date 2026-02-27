/// Custom metadata that is associated to predefined attributes to control
/// behavior in upstream services, such as
/// controlling how a predefined attribute should be displayed in the Amazon
/// Connect admin website.
pub const InputPredefinedAttributeConfiguration = struct {
    /// When this parameter is set to true, Amazon Connect enforces strict
    /// validation on the specific values, if the
    /// values are predefined in attributes. The contact will store only valid and
    /// predefined values for the predefined
    /// attribute key.
    enable_value_validation_on_association: bool = false,

    pub const json_field_names = .{
        .enable_value_validation_on_association = "EnableValueValidationOnAssociation",
    };
};
