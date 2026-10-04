/// Information about an evaluation form item affected by a validation finding.
pub const EvaluationFormValidationFindingItem = struct {
    /// The specific property of the evaluation form item that the finding relates
    /// to.
    property: ?[]const u8 = null,

    /// The identifier of the evaluation form item (question or section) affected by
    /// the finding.
    ref_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .property = "Property",
        .ref_id = "RefId",
    };
};
