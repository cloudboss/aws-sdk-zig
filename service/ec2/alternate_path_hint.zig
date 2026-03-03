/// Describes an potential intermediate component of a feasible path.
pub const AlternatePathHint = struct {
    /// The Amazon Resource Name (ARN) of the component.
    component_arn: ?[]const u8 = null,

    /// The ID of the component.
    component_id: ?[]const u8 = null,
};
