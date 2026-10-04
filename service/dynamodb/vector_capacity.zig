/// The consumed capacity for vector index operations, including vector search
/// request bytes
/// and vector write request bytes.
pub const VectorCapacity = struct {
    /// The number of vector search request bytes consumed by a
    /// `SearchVectors` operation.
    vector_search_request_bytes: ?f64 = null,

    /// The number of vector write request bytes consumed when writing to a vector
    /// index.
    /// Reported for write operations that modify attributes indexed by a vector
    /// index.
    vector_write_request_bytes: ?f64 = null,

    pub const json_field_names = .{
        .vector_search_request_bytes = "VectorSearchRequestBytes",
        .vector_write_request_bytes = "VectorWriteRequestBytes",
    };
};
