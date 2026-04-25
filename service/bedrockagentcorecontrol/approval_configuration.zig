/// Configuration for the registry record approval workflow. Controls whether
/// records added to the registry require explicit approval before becoming
/// active.
pub const ApprovalConfiguration = struct {
    /// Whether registry records are auto-approved. When set to `true`, records are
    /// automatically approved upon creation. When set to `false` (the default),
    /// records require explicit approval for security purposes.
    auto_approval: bool = false,

    pub const json_field_names = .{
        .auto_approval = "autoApproval",
    };
};
