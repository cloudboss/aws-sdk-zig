const DocumentAttribute = @import("document_attribute.zig").DocumentAttribute;

/// Identifies a document for which to retrieve status information
pub const DocumentInfo = struct {
    /// Attributes that identify a specific version of a document to check.
    ///
    /// The only valid attributes are:
    ///
    /// * version
    ///
    /// * datasourceId
    ///
    /// * jobExecutionId
    ///
    /// The attributes follow these rules:
    ///
    /// * `dataSourceId` and `jobExecutionId` must be used
    /// together.
    ///
    /// * `version` is ignored if `dataSourceId` and
    /// `jobExecutionId` are not provided.
    ///
    /// * If `dataSourceId` and `jobExecutionId` are provided, but
    /// `version` is not, the version defaults to "0".
    attributes: ?[]const DocumentAttribute,

    /// The identifier of the document.
    document_id: []const u8,

    pub const json_field_names = .{
        .attributes = "Attributes",
        .document_id = "DocumentId",
    };
};
