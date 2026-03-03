/// The connection between two service in an insight impact graph.
pub const InsightImpactGraphEdge = struct {
    /// Identifier of the edge. Unique within a service map.
    reference_id: ?i32 = null,

    pub const json_field_names = .{
        .reference_id = "ReferenceId",
    };
};
