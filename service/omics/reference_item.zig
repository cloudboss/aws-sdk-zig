/// A genome reference.
pub const ReferenceItem = union(enum) {
    /// The reference's ARN.
    reference_arn: ?[]const u8,

    pub const json_field_names = .{
        .reference_arn = "referenceArn",
    };
};
