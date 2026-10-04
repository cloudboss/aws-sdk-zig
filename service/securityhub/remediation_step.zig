/// A step in the remediation guidance.
pub const RemediationStep = struct {
    /// The action to be taken for this step.
    action: []const u8,

    /// A description of what the step does.
    description: []const u8,

    /// The inverse of the step, to be used if the step needs to be rolled back.
    inverse: ?[]const u8 = null,

    /// The logic behind the existence of this step.
    logic: ?[]const u8 = null,

    /// The phase of the remediation plan that this step belongs to (for example,
    /// `FIX`).
    phase: []const u8,

    /// Which service this step is performed in.
    service: []const u8,

    /// The action to take after the step to verify its success.
    verify_after: ?[]const u8 = null,

    pub const json_field_names = .{
        .action = "Action",
        .description = "Description",
        .inverse = "Inverse",
        .logic = "Logic",
        .phase = "Phase",
        .service = "Service",
        .verify_after = "VerifyAfter",
    };
};
