/// Neptune logs are converted to SPARQL quads in the graph using the Resource
/// Description Framework (RDF) [N-QUADS](https://www.w3.org/TR/n-quads/)
/// language defined in the W3C RDF 1.1 N-Quads specification
pub const SparqlData = struct {
    /// Holds an [N-QUADS](https://www.w3.org/TR/n-quads/) statement expressing the
    /// changed quad.
    stmt: []const u8,

    pub const json_field_names = .{
        .stmt = "stmt",
    };
};
