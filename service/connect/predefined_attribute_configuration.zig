/// Custom metadata that is associated to predefined attributes to control
/// behavior in upstream services, such as
/// controlling how a predefined attribute should be displayed in the Amazon
/// Connect admin website.
pub const PredefinedAttributeConfiguration = struct {
    /// When this parameter is set to true, Amazon Connect enforces strict
    /// validation on the specific values, if the
    /// values are predefined in attributes. The contact will store only valid and
    /// predefined values for teh predefined
    /// attribute key.
    enable_value_validation_on_association: bool = false,

    /// A boolean flag used to indicate whether a predefined attribute should be
    /// displayed in the Amazon Connect admin website.
    is_read_only: bool = false,

    pub const json_field_names = .{
        .enable_value_validation_on_association = "EnableValueValidationOnAssociation",
        .is_read_only = "IsReadOnly",
    };
};
