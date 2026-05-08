/// Identifies a single operation to include in a composite SLI for a
/// service-level SLO. Used as an element of the `Components` list in
/// `CompositeSliConfig`.
pub const CompositeSliComponent = union(enum) {
    /// The name of the operation to include in the composite SLI.
    operation_name: ?[]const u8,

    pub const json_field_names = .{
        .operation_name = "OperationName",
    };
};
