/// An array with one or more objects that includes a security control
/// (identified with `SecurityControlId`, `SecurityControlArn`, or a mix of both
/// parameters)
/// and the Amazon Resource Name (ARN) of a standard. The security control ID or
/// ARN is the same across standards.
pub const StandardsControlAssociationId = struct {
    /// The unique identifier (identified with `SecurityControlId`,
    /// `SecurityControlArn`, or a mix of both parameters) of a security
    /// control across standards.
    security_control_id: []const u8,

    /// The ARN of a standard.
    standards_arn: []const u8,

    pub const json_field_names = .{
        .security_control_id = "SecurityControlId",
        .standards_arn = "StandardsArn",
    };
};
