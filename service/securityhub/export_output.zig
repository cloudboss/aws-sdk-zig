const FindingsOutput = @import("findings_output.zig").FindingsOutput;

/// Specifies what data to export and how to format it. This is a union: you
/// must specify exactly one member. Currently, the only supported member is
/// `Findings`.
pub const ExportOutput = union(enum) {
    /// Configures an export of Security Hub findings, including the output format
    /// and any filters or selected fields.
    findings: ?FindingsOutput,

    pub const json_field_names = .{
        .findings = "Findings",
    };
};
