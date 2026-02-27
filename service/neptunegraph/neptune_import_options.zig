/// Options for how to import Neptune data.
pub const NeptuneImportOptions = struct {
    /// Neptune Analytics supports label-less vertices and no labels are assigned
    /// unless one is explicitly provided. Neptune assigns default labels when none
    /// is explicitly provided. When importing the data into Neptune Analytics, the
    /// default vertex labels can be omitted by setting
    /// *preserveDefaultVertexLabels* to false. Note that if the vertex only has
    /// default labels, and has no other properties or edges, then the vertex will
    /// effectively not get imported into Neptune Analytics when
    /// preserveDefaultVertexLabels is set to false.
    preserve_default_vertex_labels: ?bool,

    /// Neptune Analytics currently does not support user defined edge ids. The edge
    /// ids are not imported by default. They are imported if *preserveEdgeIds* is
    /// set to true, and ids are stored as properties on the relationships with the
    /// property name *neptuneEdgeId*.
    preserve_edge_ids: ?bool,

    /// The KMS key to use to encrypt data in the S3 bucket where the graph data is
    /// exported
    s_3_export_kms_key_id: []const u8,

    /// The path to an S3 bucket from which to import data.
    s_3_export_path: []const u8,

    pub const json_field_names = .{
        .preserve_default_vertex_labels = "preserveDefaultVertexLabels",
        .preserve_edge_ids = "preserveEdgeIds",
        .s_3_export_kms_key_id = "s3ExportKmsKeyId",
        .s_3_export_path = "s3ExportPath",
    };
};
